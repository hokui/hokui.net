class RenameColumnOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :first_name, :family_name
  end
end
