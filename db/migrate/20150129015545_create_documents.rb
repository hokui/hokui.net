class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :subject,    index: true, null: false
      t.integer    :class_year, index: true, null: false
      t.integer    :code,       index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :documents, :subjects

    add_index :documents, [:subject_id, :class_year, :code], unique: true
  end
end
