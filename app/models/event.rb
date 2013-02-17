class Event < ActiveRecord::Base
  attr_accessible :date, :entity_id, :entity_type, :location_id, :time, :event_type, :year, :month, :day, :hour, :minute, :second, :timezone
  belongs_to :entity, polymorphic:true
end
