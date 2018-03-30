class AddSlugToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :slug, :integer
  end
end
