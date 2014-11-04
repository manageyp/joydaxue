class AddAvatarToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :avatar, :string, after: :telephone
  end
end
