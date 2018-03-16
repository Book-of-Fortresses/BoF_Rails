class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :at_locations_table_id
      t.integer :location_id
      t.string :primary_site_name
      t.string :latitude
      t.string :longitude
      t.string :at_perspective_drawings_ids
      t.string :wikipedia_link
      t.string :fortalezas_link
      t.string :castillosnet_link
      t.string :at_collaborator_id
      t.string :a360_3D_model_link
      t.string :at_locations_table_time_created

      t.timestamps
    end
  end
end
