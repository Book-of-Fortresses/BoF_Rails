class RemoveLookupsFromPerspectiveDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :perspective_drawings, :wikipedia_link, :string
    remove_column :perspective_drawings, :fortalezas_link, :string
    remove_column :perspective_drawings, :at_collaborator_id, :string
  end
end
