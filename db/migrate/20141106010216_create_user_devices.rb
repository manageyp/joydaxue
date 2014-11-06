class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.integer :user_id
      t.string :client_type
      t.integer :device_id
      t.string :device_name
      t.string :device_agent

      t.timestamps
    end

    add_index :user_devices, :user_id
    add_index :user_devices, :client_type
    add_index :user_devices, :device_id
  end
end
