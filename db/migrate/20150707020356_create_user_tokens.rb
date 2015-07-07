class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.integer :user_id, null: false
      t.string :token, null: false
      t.datetime :expired_at

      t.timestamps
    end

    add_index :user_tokens, :user_id, unique: true
    add_index :user_tokens, :token, unique: true
  end
end
