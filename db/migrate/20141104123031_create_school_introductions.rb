class CreateSchoolIntroductions < ActiveRecord::Migration
  def change
    create_table :school_introductions do |t|
      t.integer :school_id, null: false
      t.string :short_content
      t.text :full_content

      t.timestamps
    end

    add_index :school_introductions, :school_id
  end
end
