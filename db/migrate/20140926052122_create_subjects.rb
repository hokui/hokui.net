class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title_ja, null: false
      t.string :title_en, null: false

      t.timestamps
    end

    add_index :subjects, :title_ja, unique: true
    add_index :subjects, :title_en, unique: true
  end
end
