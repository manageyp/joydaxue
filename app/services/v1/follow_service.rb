# -*- encoding : utf-8 -*-

module V1
  class FollowService

    class << self

      def follow(params)
        if User.exists?(id: params[:user_id])
          if params[:current_user_id] == params[:user_id]
            ErrorCode.error_content(:user_cannot_follow_self)
          else
            Follow.follow(params[:user_id], params[:current_user_id])
            [true, {success: true}]
          end
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

      def unfollow(params)
        if User.exists?(id: params[:user_id])
          Follow.unfollow(params[:user_id], params[:current_user_id])
          [true, {success: true}]
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

    end

  end
end