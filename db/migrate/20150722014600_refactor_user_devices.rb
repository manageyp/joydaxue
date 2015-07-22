class RefactorUserDevices < ActiveRecord::Migration
  def change
    remove_index :user_devices, :client_type
    remove_column :user_devices, :client_type

    remove_column :user_devices, :device_name
    remove_column :user_devices, :device_agent

    change_column(:user_devices, :device_id, :string)

    add_column :user_devices, :device_type, :string, after: :user_id

    add_column :user_devices, :device_token, :string, after: :device_id
    add_index :user_devices, :device_token

    add_column :user_devices, :status, :integer, default: 0, after: :device_token
  end
end
