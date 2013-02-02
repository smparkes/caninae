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

File.open("tollermaster.csv", "r:iso-8859-1") do |f|
  header = f.readline.split(',').map(&:chomp)
  dog = {}
  f.each do |line|
    values = line.split(",")
    tollerdata = {}
    header.each_with_index do |field_name, i|
      tollerdata[field_name] =
        values[i].chomp
    end
    dog[:tollerdata] = tollerdata
    dog[:id] = tollerdata["ID"].to_i
    dog[:sire_id] = tollerdata["SIREID"].to_i
    dog[:dam_id] = tollerdata["DAMID"].to_i
    squish dog, "call_name", tollerdata["CALLNAME"]
    ap MultiJson.dump(dog)
  end
end
