class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.integer :user_id, null: false
      t.string :token, null: false
      t.datetime :expired_at

      t.timestamps
    end

    add_index :access_tokens, :user_id, unique: true
    add_index :access_tokens, :token, unique: true
  end
end
