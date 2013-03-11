class Tollerdata::Health::Category < ActiveRecord::Base
  attr_accessible :name

  def self.general_background
    self.find_by_name "General Background"
  end

end
