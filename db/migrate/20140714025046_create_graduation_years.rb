class CreateGraduationYears < ActiveRecord::Migration
  def change
    create_table :graduation_years do |t|
      t.integer :year, null: false

      t.timestamps
    end

    add_index :graduation_years, :year, unique: true

    change_table :users do |t|
      t.integer :graduation_year_id, default: 1, null: false
    end

    add_index :users, :graduation_year_id
  end
end
