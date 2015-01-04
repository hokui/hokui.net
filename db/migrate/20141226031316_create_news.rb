class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :text, null: false

      t.timestamps null: false
    end
  end
end
