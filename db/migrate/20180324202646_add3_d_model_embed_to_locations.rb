class Add3DModelEmbedToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :A360_3D_model_embed, :string
    add_column :locations, :agol_map_location_embed, :string
    add_column :locations, :agol_map_location_link, :string
  end
end
