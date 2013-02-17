class AnimalOwner < ActiveRecord::Base
  attr_accessible :animal_id, :owner_id
end
