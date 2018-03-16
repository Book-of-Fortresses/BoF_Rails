class ChangePointToStPointToLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :latlon # formerly of type :point
    add_column :locations, :latlon, :geography, limit: {:srid=>4326, :type=>"point", :geographic=>true}
  end
end
