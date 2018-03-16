class AddImageTypeToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :image_type, :string
  end
end
