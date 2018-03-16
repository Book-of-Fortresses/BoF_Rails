class Image < ApplicationRecord
  belongs_to :perspective_drawing, :foreign_key => 'at_perspective_drawings_table_id', :primary_key => 'at_perspective_drawings_table_id', optional: true

  belongs_to :location, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_table_id', optional: true
end
