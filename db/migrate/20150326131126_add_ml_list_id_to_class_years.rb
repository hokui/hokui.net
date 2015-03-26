class AddMlListIdToClassYears < ActiveRecord::Migration
  def change
    add_column :class_years, :ml_list_id, :integer
  end
end
