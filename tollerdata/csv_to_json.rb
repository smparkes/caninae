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

File.open("tollermaster.csv", "r:iso-8859-1") do |f|
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
      dog[:import_json] = MultiJson.dump(tollerdata)
      dog[:id] = tollerdata["ID"].to_i
      dog[:father_id] = tollerdata["SIREID"].to_i
      dog[:mother_id] = tollerdata["DAMID"].to_i
      squish dog, "name", tollerdata["NAME"]
      squish dog, "call_name", tollerdata["CALLNAME"]
      sex dog, tollerdata
      File.write("tollerdata/#{dog[:id]}", MultiJson.dump(dog))
    rescue Object
      ap tollerdata
    end
  end
end
