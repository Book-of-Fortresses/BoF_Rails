class RenamePerspectiveDrawingsFieldsInImages < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :at_perspective_drawings_table_id, :at_images_table_id
    rename_column :images, :at_perspective_drawings_table_time_created,  :at_images_table_time_created
  end
end
