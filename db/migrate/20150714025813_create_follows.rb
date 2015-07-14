class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_id, null: false
      t.integer :to_user_id, null: false

      t.timestamps
    end

    add_index :follows, [:user_id, :to_user_id], unique: true
  end
end
