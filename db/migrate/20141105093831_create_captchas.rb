class CreateCaptchas < ActiveRecord::Migration
  def change
    create_table :captchas do |t|
      t.string :captcha_type, null: false
      t.string :mobile, null: false
      t.integer :send_count, default: 0
      t.string :code, null: false

      t.timestamps
    end

    add_index :captchas, [:captcha_type, :mobile], unique: true
  end
end
