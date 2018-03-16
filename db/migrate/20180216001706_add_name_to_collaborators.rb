class AddNameToCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_column :collaborators, :name, :string
    add_column :collaborators, :airtable_id, :string
    add_column :collaborators, :email, :string
    add_column :collaborators, :major, :string
    add_column :collaborators, :graduation, :integer
    add_column :collaborators, :active, :string
  end
end
