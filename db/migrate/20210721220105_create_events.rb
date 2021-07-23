class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :at_event_id
      t.text :notes
      t.string :location_ids
      t.string :date_type
      t.datetime :end_date
      t.datetime :earliest_begin_date
      t.integer :order
      t.string :major_event_type
    end
  end
end
