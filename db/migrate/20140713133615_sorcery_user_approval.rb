class SorceryUserApproval < ActiveRecord::Migration
  def change
    add_column :users, :approval_state, :string, :default => nil
  end
end
