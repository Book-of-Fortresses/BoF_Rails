class AddLatLonToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :latlon, :point, :geographic => true
  end
end
