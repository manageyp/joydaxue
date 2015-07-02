module V1
  class UserService

    class << self

      def get_user_detail(params)
        current_user_id = params[:user_id]
        user = User.find_by_id(params[:id])
        if user.present?
          [user, V1::UserWrapper.user_detail(user, current_user_id)]
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

    end

  end
end