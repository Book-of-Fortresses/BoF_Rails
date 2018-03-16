class RemoveAirtableIdFromCollaborators < ActiveRecord::Migration[5.1]
  def change
    remove_column :collaborators, :airtable_id, :string
  end
end
