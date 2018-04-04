class AddAgolSlideEmbedToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :agol_slide_embed, :string
  end
end
