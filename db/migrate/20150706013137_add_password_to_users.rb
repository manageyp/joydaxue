class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password, :string, after: :memo
    add_column :users, :password_salt, :string, after: :password
    remove_column :users, :display_name
  end
end
