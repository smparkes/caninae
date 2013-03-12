class Event < ActiveRecord::Base
  attr_accessible :date, :entity_id, :entity_type, :location_id, :time, :event_type, :year, :month, :day, :hour, :minute, :second, :timezone
  belongs_to :entity, polymorphic:true

  def to_epoch
    return nil if year.blank?
    Date.new(*([year, month || 6, day || 15].compact)).to_time.to_i
  end

end
