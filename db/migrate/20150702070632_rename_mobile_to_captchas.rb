class RenameMobileToCaptchas < ActiveRecord::Migration
  def change
    remove_index :captchas, [:captcha_type, :mobile]
    rename_column :captchas, :mobile, :cellphone
    add_index :captchas, [:captcha_type, :cellphone], unique: true
  end
end
