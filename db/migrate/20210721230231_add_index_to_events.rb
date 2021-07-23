class AddIndexToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :location_ids, :at_location_id
    add_index :events, :at_location_id
  end
end
