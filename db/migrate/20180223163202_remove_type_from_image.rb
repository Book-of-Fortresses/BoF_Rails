class RemoveTypeFromImage < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :type, :string
  end
end
