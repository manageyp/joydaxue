class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :cellphone, null: false
      t.string :display_name
      t.integer :sex
      t.integer :status, default: 0
      t.string :memo

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :email, unique: true
    add_index :users, :cellphone, unique: true
  end
end
