class AddAtLocationsTableIdToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :at_locations_table_id, :string
  end
end
