class Location < ActiveRecord::Base
  attr_accessible :city, :country, :latitude, :longitude, :resolution, :state, :street
end