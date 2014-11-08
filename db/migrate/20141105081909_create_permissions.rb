class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :role_id, null: false
      t.string :controller_name
      t.string :action_names

      t.timestamps
    end

    add_index :permissions, [:role_id, :controller_name]
  end
end
