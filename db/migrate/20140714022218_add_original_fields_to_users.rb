class AddOriginalFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string  :first_name,      default: "",    null: false
      t.string  :given_name,      default: "",    null: false
      t.string  :handle_name,     default: "",    null: false
      t.date    :birthday,        default: "",    null: false
      t.string  :email_mobile
      t.boolean :admin,           default: false, null: false
    end

    add_index :users, :handle_name, unique: true
  end
end
