class CreateClassYears < ActiveRecord::Migration
  def change
    create_table :class_years do |t|
      t.integer :year, null: false

      t.timestamps
    end

    add_index :class_years, :year, unique: true

    change_table :users do |t|
      t.integer :class_year_id, default: 1, null: false
    end

    add_index :users, :class_year_id
  end
end
