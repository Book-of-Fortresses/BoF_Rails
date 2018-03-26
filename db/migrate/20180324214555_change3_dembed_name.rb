class Change3DembedName < ActiveRecord::Migration[5.1]
  rename_column :locations, :A360_3D_model_embed, :a360_3D_model_embed
end
