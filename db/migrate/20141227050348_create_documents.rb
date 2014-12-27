class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :subject,        null: false, index: true
      t.references :user,           null: false, index: true
      t.integer    :class_year,     null: false, index: true
      t.integer    :document_type,  null: false
      t.integer    :number,         null: false, default: 1
      t.integer    :page,           null: false, default: 1
      t.boolean    :with_answer
      t.string     :note
      t.integer    :download_count, null: false, default: 0
      t.string     :file_name,      null: false
      t.string     :file_mime,      null: false
      t.string     :file_sha1,      null: false

      t.timestamps null: false
    end

    add_foreign_key :documents, :subjects
    add_foreign_key :documents, :users

    add_index :documents, :file_sha1, unique: true
  end
end
