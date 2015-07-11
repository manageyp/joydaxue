class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.string :detail_type, null: false
      t.integer :detail_id, null: false

      t.timestamps
    end

    add_index :favorites, :user_id
    add_index :favorites, [:detail_type, :detail_id], unique: true
  end
end
