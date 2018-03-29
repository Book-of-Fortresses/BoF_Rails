class RenameLocationRecordIDtoItineraryOrder < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :location_id, :itinerary_order
  end
end
