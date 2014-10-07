class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :class_year_id, null: false
      t.string  :identifier,    null: false

      t.timestamps
    end

    add_index :semesters, :class_year_id
    add_index :semesters, [:class_year_id, :identifier], unique: true
  end
end
