class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.integer  :user_id,          null: false
      t.string   :token,            null: false
      t.datetime :last_activity_at

      t.timestamps
    end

    add_index :access_tokens, :token, unique: true
  end
end
