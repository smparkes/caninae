class Dominate < ActiveRecord::Base
  attr_accessible :dominated_id, :dominator_id
end
