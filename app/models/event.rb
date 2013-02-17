class Event < ActiveRecord::Base
  attr_accessible :date, :entity_id, :entity_type, :integer, :location_id, :string, :time, :type
end
