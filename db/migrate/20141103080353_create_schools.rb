class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :province_id, null: false
      t.integer :city_id, null: false
      t.string :name, null: false
      t.string :address

      t.string :college_type
      t.string :telephone
      t.string :website
      t.string :found_year
      t.string :zipcode
      t.string :affiliate

      t.decimal :latitude, precision: 10, scale: 6, default: 0
      t.decimal :longitude, precision: 10, scale: 6, default: 0

      t.boolean :is_211, default: false
      t.boolean :is_985, default: false
      t.boolean :is_edu_affiliate, default: false
      t.boolean :has_bachelor, default: false
      t.boolean :is_independent, default: false
      t.boolean :is_civilian_run, default: false

      t.integer :key_disciplines, default: 0
      t.integer :master_num, default: 0
      t.integer :phd_num, default: 0
      t.integer :academician_num, default: 0

      t.timestamps
    end

    add_index :schools, :province_id
    add_index :schools, :city_id
    add_index :schools, :name
    add_index :schools, :address
    add_index :schools, :college_type
    add_index :schools, :is_211
    add_index :schools, :is_985
    add_index :schools, :is_edu_affiliate
    add_index :schools, :has_bachelor

  end
end
