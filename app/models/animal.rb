class Animal < ActiveRecord::Base
  attr_accessible :address_id, :birth_id, :call_name, :death_id, :father_id, :import_json, :litter_id, :mother_id, :name, :sex
end
