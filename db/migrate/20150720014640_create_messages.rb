class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.string :detail_type, null: false
      t.integer :detail_id, null: false
      t.string :description
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :messages, :sender_id
    add_index :messages, :receiver_id
    add_index :messages, :detail_type
  end
end
