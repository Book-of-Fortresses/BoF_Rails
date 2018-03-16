class Location < ApplicationRecord
  has_many :perspective_drawings, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_table_id'

  has_many :images, :foreign_key => 'at_locations_table_id',
  :primary_key => 'at_locations_table_id'

  def to_param
    slug
  end
  
end
