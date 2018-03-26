class RenameFolioNumberToPageNumber < ActiveRecord::Migration[5.1]
  def change
    add_column :perspective_drawings, :page_number, :integer
    remove_column :perspective_drawings, :folio_number, :integer
  end
end
