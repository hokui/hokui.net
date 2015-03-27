class AddMlMemberIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ml_member_id, :integer
  end
end
