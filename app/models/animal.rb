class Animal < ActiveRecord::Base
  has_one :mother, class_name:Animal
  has_one :father, class_name:Animal
  has_one :birth, as:"entity", class_name:Event, conditions:['event_type = ?', :birth]
  has_one :death, as:"entity", class_name:Event, conditions:['event_type = ?', :death]
  has_many :offspring
  has_many :events, as:"entity"
  attr_accessible :address_id, :birth_id, :call_name, :death_id, :father_id, :import_json, :litter_id, :mother_id, :name, :sex
end
