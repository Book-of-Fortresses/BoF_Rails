class AddColumnsToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :primary_site_name, :string
    add_column :images, :view_direction, :string
    add_column :images, :secondary_site_name, :string
    add_column :images, :secondary_site_kingdom, :string
    add_column :images, :number_of_watchtowers, :integer
    add_column :images, :exterior_features, :string
    add_column :images, :status, :string
    add_column :images, :fortress_features, :string
    add_column :images, :at_perspective_drawings_table_time_created, :string
    add_column :images, :page_number, :integer

    remove_column :perspective_drawings, :at_perspective_drawings_table_id, :string
    remove_column :perspective_drawings, :primary_site_name, :string
    remove_column :perspective_drawings, :view_direction, :string
    remove_column :perspective_drawings, :secondary_site_name, :string
    remove_column :perspective_drawings, :secondary_site_kingdom, :string
    remove_column :perspective_drawings, :number_of_watchtowers, :integer
    remove_column :perspective_drawings, :exterior_features, :string
    remove_column :perspective_drawings, :status, :string
    remove_column :perspective_drawings, :fortress_features, :string
    remove_column :perspective_drawings, :at_perspective_drawings_table_time_created, :string
    remove_column :perspective_drawings, :page_number, :integer
  end
end
