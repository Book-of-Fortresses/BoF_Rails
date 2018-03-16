class Remove < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :at_perspective_drawings_ids, :string
  end
end
