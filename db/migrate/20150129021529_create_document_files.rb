class CreateDocumentFiles < ActiveRecord::Migration
  def change
    create_table :document_files do |t|
      t.references :document,          index: true, null: false
      t.references :user,              index: true, null: false
      t.string     :file_name,                      null: false
      t.string     :file_content_type,              null: false
      t.string     :file_md5,                       null: false
      t.string     :comments
      t.integer    :download_count,                 null: false, default: 0

      t.timestamps null: false
    end

    add_foreign_key :document_files, :documents
    add_foreign_key :document_files, :users

    add_index :document_files, :file_md5, unique: true
  end
end
