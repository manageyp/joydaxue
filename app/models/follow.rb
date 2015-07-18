# == Schema Information
#
# Table name: follows 用户关注
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null  用户 ID
#  to_user_id  :integer          not null  关注的用户 ID
#  created_at  :datetime
#  updated_at  :datetime

class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :to_user, class_name: "User", foreign_key: "to_user_id"

  class << self

    def is_fans?(current_user_id, to_user_id)
      exists?(user_id: current_user_id, to_user_id: to_user_id)
    end

    def paginate_follows(user_id, min_created_at, page = 1, per_page = 20)
      query = where(user_id: user_id)
      if min_created_at.present?
        query = query.where("created_at < ?", min_created_at)
      end
      query.includes(:to_user).page(page).per(per_page).order("created_at desc")
    end

    def paginate_fans(user_id, min_created_at, page = 1, per_page = 20)
      query = where(to_user_id: user_id)
      if min_created_at.present?
        query = query.where("created_at < ?", min_created_at)
      end
      query.includes(:user).page(page).per(per_page).order("created_at desc")
    end

    def follow(to_user_id, current_user_id)
      unless exists?(user_id: current_user_id, to_user_id: to_user_id)
        Follow.transaction do
          new_follow = create(user_id: current_user_id, to_user_id: to_user_id)
          User.increase_follows_count(current_user_id, to_user_id)
          # Notification.build_friendship_follow_notice(new_follow.id)
        end
      end
    end

    def unfollow(to_user_id, current_user_id)
      Follow.transaction do
        follow_result = where(user_id: current_user_id, to_user_id: to_user_id).first
        if follow_result.present?
          User.decrease_follows_count(current_user_id, to_user_id)
          # Notification.delete_former_notices('follow', follow_result.id)
          follow_result.destroy
        end
      end
    end

  end

end
