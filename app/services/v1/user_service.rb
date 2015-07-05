module V1
  class UserService

    class << self

      def get_user_detail(params)
        current_user_id = params[:user_id]
        user = User.fetch_by_id(params[:id])
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

      def signup(params)
        captcha = Captcha.fetch_code(params[:cellphone])
        if captcha.present?
          if captcha.expired?
            ErrorCode.error_content(:captcha_is_expired)
          elsif !captcha.valid_code?(params[:code])
            ErrorCode.error_content(:captcha_is_invalid)
          else
            if !Util::ValidateUtil.valid_pwd?(params[:password])
              ErrorCode.error_content(:password_is_invalid)
            elsif !Util::ValidateUtil.valid_pwd_length?(params[:password])
              ErrorCode.error_content(:invalid_password_length)
            else
              user = User.register(captcha, params[:password])
              [user, V1::UserWrapper.user_detail(user)]
            end
          end
        else
          ErrorCode.error_content(:cellphone_not_existed)
        end
      end

      def signin(params)
        if params[:cellphone].blank?
          return ErrorCode.error_content(:cellphone_is_blank)
        end

        user = User.fetch_by_cellphone(params[:cellphone])
        if user.present?
          if user.valid_password?(params[:password])
            [user, V1::UserWrapper.user_detail(user)]
          else
            ErrorCode.error_content(:user_password_error)
          end
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

    end

  end
end