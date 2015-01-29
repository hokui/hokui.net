class CreateDownloadTokens < ActiveRecord::Migration
  def change
    create_table :download_tokens do |t|
      t.references :document_file, index: true, null: false
      t.string     :token,                      null: false

      t.timestamps null: false
    end

    add_foreign_key :download_tokens, :document_files

    add_index :download_tokens, :token, unique: true
  end
end
