class Litter < ActiveRecord::Base
  attr_accessible :event_id, :father_id, :mother_id, :name
end
