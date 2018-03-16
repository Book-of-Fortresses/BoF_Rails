class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :at_image_id
      t.string :url
      t.string :filename
      t.integer :size
      t.string :type
      t.string :small_thumbnail_url
      t.integer :small_thumbnail_width
      t.integer :small_thumbnail_height
      t.string :large_thumbnail_url
      t.integer :large_thumbnail_width
      t.integer :large_thumbnail_height
      t.string :at_perspective_drawings_table_id

      t.timestamps
    end
  end
end
