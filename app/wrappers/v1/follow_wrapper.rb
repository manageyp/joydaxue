# -*- encoding : utf-8 -*-

module V1
  class FollowWrapper

    class << self

      def follows_data(follows, current_user_id)
        ret = []
        follows.each do |follow|
          user_data = V1::UserWrapper.owner_info(follow.to_user)
          user_data[:is_fans] = if current_user_id.present?
            Follow.is_fans?(current_user_id, follow.to_user_id)
          else
            false
          end
          ret << user_data
        end
        ret
      end

      def fans_data(fans, current_user_id)
        ret = []
        fans.each do |fan|
          user_data = V1::UserWrapper.owner_info(fan.user)
          user_data[:is_fans] = if current_user_id.present?
            Follow.is_fans?(current_user_id, fan.user_id)
          else
            false
          end
          ret << user_data
        end
        ret
      end

    end

  end
end
