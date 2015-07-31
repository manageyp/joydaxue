class CreateUserLogins < ActiveRecord::Migration
  def change
    create_table :user_logins do |t|
      t.integer :user_id, null: false
      t.string :login_type
      t.string :login_ip
      t.string :location
      t.datetime :login_at

      t.timestamps
    end

    add_index :user_logins, :user_id
    add_index :user_logins, :login_ip
  end
end
