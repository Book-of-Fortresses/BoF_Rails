class PerspectiveDrawing < ApplicationRecord
  belongs_to :location, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_table_id'

  has_many :images, :foreign_key => 'at_perspective_drawings_table_id', :primary_key => 'at_perspective_drawings_table_id'
end
