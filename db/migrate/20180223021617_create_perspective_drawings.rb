class CreatePerspectiveDrawings < ActiveRecord::Migration[5.1]
  def change
    create_table :perspective_drawings do |t|
      t.string :at_perspective_drawings_table_id
      t.integer :folio_number
      t.string :primary_site_name
      t.string :view_direction
      t.string :secondary_site_name
      t.string :secondary_site_kingdom
      t.integer :number_of_watchtowers
      t.string :exterior_features
      t.string :at_locations_table_id
      t.string :status
      t.string :fortress_features
      t.string :wikipedia_link
      t.string :at_collaborator_id
      t.string :fortalezas_link
      t.string :at_perspective_drawings_table_time_created

      t.timestamps
    end
  end
end
