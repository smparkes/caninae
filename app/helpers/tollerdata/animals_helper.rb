module Tollerdata::AnimalsHelper

  def image json
    image = json["IMAGE"]
    if image.blank? && @animal.id == 20561
      image = "http://i1275.photobucket.com/albums/y459/aptosca/glori_zps983be6ee.png"
    end
    image.blank? ? nil : image
  end

  def image_user json
    user = clean(json["IMAGEUSER"])
    if user.blank? && @animal.id == 20561
      user = "Steven Parkes"
    end
    user.blank? ? nil : user
  end

  def web_site json
    web_site = json["WEBSITE"]
    if (web_site.blank? || web_site == "http://") && @animal.id == 20561
      web_site = "http://on.fb.me/ZCWfmg"
    end
    web_site.blank? ? nil : web_site
  end

  def clean string
    string = string.squish if string
    string.blank? ? nil : string
  end

  COUNTRIES = {
    "US" => "USA",
    "FI" => "Finland",
    "CA" => "Canada"
  }

  def country_name code
    code.upcase! if code
    COUNTRIES[code] || code
  end

  def country json
    country_name(clean json["COUNTRY"])
  end
  
  def name jsona
    clean json["NAME"]
  end
  
  def link_name json
    clean [prefix(json), json["NAME"], suffix(json)].join(" ")
  end
  
  def prefix json
    clean json["FRONTTITLES"]
  end
  
  def suffix json
    clean json["ENDTITLES"]
  end
  
  def color json
    clean json["COLOR"]
  end
  
  def registry json
    clean json["REGISTRY"]
  end

  def registration_number json
    clean json["REGISTRATIONNUMBER"]
  end
  
  def breeder json
    clean json["BREEDER"]
  end
  
  def owner json
    clean json["OWNER"]
  end
  
  def death_reason json
    clean json["DEATHREASON"]
  end

  def addl_death_reason json
    clean json["ADDLDEATHREASON"]
  end

  def pra_test json
    case clean(json["PRATEST"].downcase)
    when 'a'; "Clear"
    when 'b'; "Carrier"
    when 'c'; "Affected"
    end
  end

  def cea_test json
    case clean(json["CEATEST"].downcase)
    when 'a'; "Clear"
    when 'b'; "Carrier"
    when 'c'; "Affected"
    end
  end

  def combine json, a, b
    clean [clean(json[a]), clean(json[b])].compact.join(" ")
  end

  def hips json
    combine json, "HIPREGISTRY", "HIPID"
  end
  
  def eyes json
    combine json, "EYEREGISTRY", "EYEID"
  end
  
  def heart json
    combine json, "HEARTREGISTRY", "HEARTID"
  end
  
  def elbows json
    combine json, "ELBOWREGISTRY", "ELBOWID"
  end
  
  def thyroid json
    combine json, "THYROIDREGISTRY", "THYROIDID"
  end
  
  def longevity animal
    birth = animal.birth
    death = animal.death
    return nil if !death || !birth
    years = (death.to_epoch - birth.to_epoch)/(365*24*60.0*60.0)
    int = years.truncate
    years -= int
    if years > 2.0/3
      years = "#{int+1}"
    elsif years > 1.0/3
      years = "#{int}.5"
    else 
      years = int.to_s
    end
    "#{years} years"
  end

end
