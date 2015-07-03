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

      def send_captcha(cellphone)
        if cellphone.blank?
          return ErrorCode.error_content(:cellphone_is_blank)
        end

        if !Util::ValidateUtil.valid_cellphone?(cellphone)
          ErrorCode.error_content(:cellphone_format_invalid)
        elsif User.exists?(cellphone: cellphone)
          ErrorCode.error_content(:cellphone_is_existed)
        else
          captcha = Captcha.build_captcha(cellphone)
          if captcha
            UserWorker.delay.deliver_cellphone_captcha(captcha)
            [captcha, {success: true}]
          else
            ErrorCode.error_content(:captcha_limit_count)
          end
        end
      end

    end

  end
end