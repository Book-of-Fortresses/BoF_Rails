class AddAirtableTableIDsToCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_column :collaborators, :at_collaborator_table_id, :string
    add_column :collaborators, :at_collaborator_id, :string
    add_column :collaborators, :at_collaborator_table_time_created, :string
  end
end
