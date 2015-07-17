class AddFollowsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :follows_count, :integer, default: 0, after: :sex
    add_column :users, :fans_count, :integer, default: 0, after: :follows_count
  end
end
