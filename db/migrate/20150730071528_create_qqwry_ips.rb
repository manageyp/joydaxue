class CreateQqwryIps < ActiveRecord::Migration
  def change
    create_table :qqwry_ips do |t|
      t.string :start_long
      t.string :end_long
      t.string :country
      t.string :location
      t.string :start_ip
      t.string :end_ip

      t.timestamps
    end

    add_index :qqwry_ips, :start_long
    add_index :qqwry_ips, :end_long
  end
end
