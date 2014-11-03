class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :province_id, null: false
      t.string :name

      t.timestamps
    end

    add_index :cities, :province_id
    add_index :cities, :name
  end
end
