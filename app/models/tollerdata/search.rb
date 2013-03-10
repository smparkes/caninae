class Tollerdata::Search
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::MassAssignmentSecurity

  def persisted?; false; end

  attr_accessible :query
  attr_accessor :query

end
