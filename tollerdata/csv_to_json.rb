#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'bundler'
Bundler.require

def clean v
  return nil if !v
  # p [v.sub(/^[[:space:]]+/, ""), v[0].ord]
  v = v.
    sub(/^[[:space:]]+/, "").
    sub(/[[:space:]]+$/, "").
    gsub(/[[:space:]][[:space:]]+/, " ")
  v.empty? ? nil : v
end

def squish dog, field, v
  return if !v
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

def register dog, tollerdata
  # p [dog, tollerdata]
  registry = clean tollerdata["REGISTRY"]
  number = (clean(tollerdata["REGISTRATIONNUMBER"]) || "").gsub('"', "")
  number = (clean(number) || "")

  return if ["UK KC",
             "STEVE TUCSOK",
             "UNREGISTERED" ,
             "MUDDUS" ,
             "FIN"].include? number.upcase

  if !number.empty?
    number.sub! "SLR NSR", "SLRNSR"
    number.sub! "(DK)", "DK"
    number.sub! "N.H.S.B.", "NHSB"
    number.sub! /nhsb:/i, "NHSB"
    number.sub! %r{^FCI\s+}, ""
    number.sub! %r{\bNHSB(\d)}i, 'NHSB \1'
    if !registry || registry.upcase == "FCI" || registry.upcase == "OTHER"
      country = clean(tollerdata["COUNTRY"]) || ""
      country = "CH" if country == "Switzerland"
      country = "GB" if country == "U.K."
      if number =~ /\bNHSB\b/i
        registry = "NHSB"
        number = clean number.sub(/NHSB/i, "")
      elsif number =~ %r{^VDH/?\s*}
        registry = "VDH"
        number = clean number.sub("VDH/\s*", "")
      elsif number.upcase.start_with?("N") &&
          ("NO".casecmp(country) == 0 || "FI".casecmp(country) == 0)
        registry = "NKK"
      elsif number =~ /\bSHSB\b/i || number =~ /\bSHSB\d/i
        registry = "SKG"
      elsif number =~ /\bFKK\b/i
        registry = "FKK"
        number = clean number.sub("FKK", "")
      elsif number =~ /\bDRET\b/i
        registry = "ÖHZB"
      elsif number =~ /\b[OÖ]HZB\b/i
        registry = "ÖHZB"
        number = clean number.sub("[OÖ]HZB", "")
      elsif number =~ /\bANKC\b/i || number =~ /\bANKC\d/i
        registry = "ANKC"
        number = clean number.sub("ANKC", "")
      elsif number =~ /\bLOF\b/i || number =~ /\bLOF\d/i
        registry = "SCC"
      elsif number =~ %r{^DKK?[[:space:]]*\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}i
        registry = "DKK"
      elsif number.upcase =~ %r{^FIN?\s*\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        registry = "FKK"
      elsif number.upcase =~ %r{^NO?\s*\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        registry = "NKK"
      # not sure about this ...
      elsif number.upcase =~ %r{^SF\s*\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        registry = "FKK"
      elsif "no".casecmp(country) == 0 &&
          number.upcase =~ %r{^\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        number = "NO"+number
        registry = "NKK"
      elsif "ch".casecmp(country) == 0 &&
          number =~ %r{^\d+$}
        number = "SHSB "+number
        registry = "SKG"
      elsif "se".casecmp(country) == 0 &&
          number.upcase =~ %r{^\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        number = "SE"+number
        registry = "SKK"
      elsif "nl".casecmp(country) == 0 && number.upcase =~ %r{^\d+$}
        registry = "NHSB"
      elsif "dk".casecmp(country) == 0 &&
          number.upcase =~ %r{^\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        number = "DKK"+number
        registry = "NKK"
      elsif "DK".casecmp(country) == 0 && number.upcase.start_with?("SE")
        registry = "SKK"
      elsif "SE".casecmp(country) == 0 && number.upcase.start_with?("S")
        registry = "SKK"
      elsif "FI".casecmp(country) == 0 && number.upcase.start_with?("FI")
        registry = "FKK"
      elsif "DK".casecmp(country) == 0 && number.upcase.start_with?("DK")
        registry = "DKK"
      elsif "GB".casecmp(country) == 0 && number =~ /^A[FGDEKPHL]\d/i
        registry = "KC"
      elsif number.upcase.start_with?("SLRNSR")
        registry = "KZS"
      elsif number.upcase.match %r{^DRC[-\s]}
        registry = "VDH"
      elsif "AU".casecmp(country) == 0 && number =~ /^[23649]100/
        registry = "ANKC"
      elsif "DE".casecmp(country) == 0 && number =~ /^\d{2}-\d{4}$/
        number = "DRC-T "+number
        registry = "VDH"
      elsif number =~ %r{^[CČ]LP/}i
        registry = "ČMKU"
      elsif "CZ".casecmp(country) == 0 && number =~ %r{^\d+$}i
        number = "ČLP/NSR/"+number
        registry = "ČMKU"
      elsif number =~ %r{^LOSH}i
        registry = "SRSH"
      elsif "BE".casecmp(country) == 0 && number =~ %r{^\d+$}
        number = "LOSH"+number
        registry = "SRSH"
      elsif "CA".casecmp(country) == 0 && number =~ %r{^[a-z]{2}([\d/])+$}i
        registry = "CKC"
      elsif "US".casecmp(country) == 0 && number =~ %r{^[a-z]{2}\s*([\d/-])+$}i
        registry = "AKC"
      elsif "GB".casecmp(country) == 0 && number =~ %r{^[SU]\d+[TU]O[14]$}i
        registry = "KC"
      elsif number.sub! %r{^PKR\.}, ""
        registry = "ZKwP"
      elsif number.sub! %r{^RKF }, ""
        registry = "RKF"
      elsif !registry && number.casecmp("ANKC") == 0
        number = nil
      elsif number.upcase == "RKF"
        number = nil
      elsif (clean(tollerdata["WEBSITE"]) || "").downcase.end_with? ".ru"
        registry = "RKF"
      elsif number =~ /^KC /
        registry = "KC"
        number = number.sub(/KC\s+/, "")
      elsif number.upcase =~ %r{^SE?\s*\d+/(((20)?[01][0-9])|((19)?[5-9][0-9]))$}
        registry = "SKK"
      elsif number =~ /^[239]100/
        registry = "ANKC"
      elsif number =~ /^VIII-\d+$/
        registry = "ZKwP"
      end
    end

    return if !number

    case registry.upcase
    when "KC"; # The Kennel Club (UK)
    when "SKG"; # The Swiss Kennel Club
    when "SCC"; # Société Centrale Canine
    when "ZKWP"; # Związek Kynologiczny w Polsce
    when "RKF";
    when "SRSH";
      number.sub!(/^LOSH\s+/, "LOSH")
    when "FKK";
      number.sub! /^(fin?)\s+(\d)/i, '\1\2'
    when "AKC";
      number.gsub! %r{/-}, ""
      number.gsub! %r{^[a-z][a-z]\s+}i, '\1'
    when "UKC";
    when "ANKC";
      # Remove the ' LR' on litter regs
      number.sub!(/ lr$/i, '')
    when "NHSB";
    when "CKC";
      number.gsub! %r{^[a-z][a-z]\s+}i, '\1'
    when "SKK";
      number.sub! /^(se?)\s+(\d)/i, '\1\2'
    when "NKK";
    when "KZS";
      number.sub! /SLRNSR\s+/i, '\1-'
    when "VDH";
    # when "UFKC";
    when "DKK";
      number.sub! /^(dkk?)\s+(\d)/i, '\1\2'
    when "ÖHZB";
    when "ČMKU";
      number = number.sub(%r{^C}, "Č").sub(%r{^c}, "č")
    else; raise [number, registry].inspect
    end

    if number =~ /\s/ && !["VDH", "ÖHZB", "SKG", "SCC", "NHSB"].include?(registry)
      raise [number, registry].inspect
    end
  end
end

fixes = {
  517 => {
    "REGISTRY" => "SKG",
  },
  683 => {
    "REGISTRY" => "SKG",
  },
  19971 => {
    "REGISTRATIONNUMBER" => nil,
  },
  22888 => {
    "REGISTRATIONNUMBER" => "310017255",    
  },
  26969 => {
    "REGISTRY" => "ANKC",
    "REGISTRATIONNUMBER" => "1598574",
  },
  24178 => {
    "REGISTRATIONNUMBER" => "S16278/2005",
  },
  29091 => {
    "REGISTRY" => "NHSB",
  },
  20890 => {
    "REGISTRY" => "NHSB",
  },
  30815 => {
    "BIRTHDAY" => 26,
    "BIRTHMONTH" => 12,
    "BIRTHYEAR" => 2010
  },
  31697 => {
    "REGISTRATIONNUMBER" => "FIN 43307/05"
  },
  31703 => {
    "REGISTRY" => nil
  },
  111134778 => {
    "REGISTRATIONNUMBER" => "SE41595/2012"
  },
  31260 => {
    "REGISTRATIONNUMBER" => "SLRNSR-000007"
  },
  30515 => {
   "REGISTRATIONNUMBER" => "LOF 158"
  },
  28987 => {
   "REGISTRATIONNUMBER" => "SHSB 647207"
  },
}

first = true
while line = gets
  l = line.dup
  if false
    line.force_encoding("windows-1252").encode!("utf-8")
  else
    begin
      line.force_encoding("UTF-8").encode("UTF-32LE").encode("UTF-8")
    rescue Encoding::InvalidByteSequenceError
      line.force_encoding("windows-1252").encode!("utf-8")
    end
  end
  if first
    first = false
    header = line.split(',').map(&:chomp)
    next
  end

  line.gsub!(/&#(\d+);/) {|s| [$1.to_i].pack("U*")}

  values = line.split(",")
  tollerdata = {}
  header.each_with_index do |field_name, i|
    v = clean values[i].chomp
    tollerdata[field_name] = v if v
  end

  next if clean(tollerdata["TESTUSERID"])

  tollerdata.delete "CP1" if tollerdata["CP1"] == "U"
  tollerdata.delete "JADD" if tollerdata["JADD"] == "U"
  tollerdata.delete "WEBSITE" if tollerdata["WEBSITE"] == "http://"

  begin
    dog = {}
    id = dog[:id] = tollerdata["ID"].to_i
    dog[:import_json] = MultiJson.dump(tollerdata)
    fixes[dog[:id]] && tollerdata.merge!(fixes[dog[:id]])
    dog[:father_id] = tollerdata["SIREID"].to_i
    dog[:mother_id] = tollerdata["DAMID"].to_i
    squish dog, :name, tollerdata["NAME"]
    squish dog, :call_name, tollerdata["CALLNAME"]
    sex dog, tollerdata
    register dog, tollerdata
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
end
