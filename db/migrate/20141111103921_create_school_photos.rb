class CreateSchoolPhotos < ActiveRecord::Migration
  def change
    create_table :school_photos do |t|
      t.integer :school_id, null: false
      t.string :image
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :school_photos, :school_id
  end
end
