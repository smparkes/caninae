#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require

def squish dog, field, v
  v =
    v.
    sub(/^\s+/, "").
    sub(/\s+$/, "").
    gsub(/\s\s+/, " ")
  dog[field] = v if v != ""
end

def sex dog, tollerdata
  case tollerdata["GENDER"]
  when /^\s*J\s*$/i
    # don't know what this means
  when /^\s*M\s*$/i
    dog[:sex] = :male
  when /^\s*F\s*$/i
    dog[:sex] = :female
  when NilClass;
  when /^\s$/;
  else
    raise "sex #{tollerdata["GENDER"]} does not parse"
  end
end

def date dog, field, tollerdata
  date =
    [:year, :month, :day].map do |resoluton|
    v = tollerdata[field.upcase.to_s+resoluton.to_s.upcase]
    v =~ /^\s*$/ ? nil : v.to_i
  end
  date.map! {|f| f == 0 ? nil : f}
  if date[1] && date[1] > 12
    date = [date[0], date[2], date[1]]
  end
  date.compact!
  if date.length == 2 && date[0] < 1900
    date[0], date[1] = date[1], date[0]
  end
  dog[field] = date unless date.empty?
end

fixes = {
  30815 => {
    "BIRTHDAY" => 26,
    "BIRTHMONTH" => 12,
    "BIRTHYEAR" => 2010
  }
}


File.open("tollermaster.csv", "r:iso-8859-1") do |f|
  count = 0
  header = f.readline.split(',').map(&:chomp)
  f.each do |line|
    values = line.split(",")
    tollerdata = {}
    header.each_with_index do |field_name, i|
      tollerdata[field_name] =
        values[i].chomp
    end
    begin
      dog = {}
      dog[:id] = tollerdata["ID"].to_i
      dog[:import_json] = MultiJson.dump(tollerdata)
      fixes[dog[:id]] && tollerdata.merge!(fixes[dog[:id]])
      dog[:father_id] = tollerdata["SIREID"].to_i
      dog[:mother_id] = tollerdata["DAMID"].to_i
      squish dog, :name, tollerdata["NAME"]
      squish dog, :call_name, tollerdata["CALLNAME"]
      sex dog, tollerdata
      date dog, :birth, tollerdata
      date dog, :death, tollerdata
      puts [dog[:id], (dog[:call_name] || dog[:name])].join(" ")
      File.write("tollerdata/#{dog[:id]}", MultiJson.dump(dog))
    rescue SystemExit
      raise
    rescue Object => ex
      ap [ex, tollerdata]
      raise
    end
    exit if (count -= 1) == 0
  end
end
