module V1
  class UserService

    class << self

      def get_user_detail(params)
        user = User.fetch_by_id(params[:id])
        if user.present?
          [user, V1::UserWrapper.owner_info(user)]
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

      def get_user_follows(params)
        user = User.fetch_by_id(params[:id])
        if user.present?
          min_created_at = Util::DateUtil.pagination_datetime(params[:page])
          follows = Follow.paginate_follows(user.id, min_created_at)
          [follows,
            V1::FollowWrapper.follows_data(follows, params[:current_user_id])]
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

      def get_user_fans(params)
        user = User.fetch_by_id(params[:id])
        if user.present?
          min_created_at = Util::DateUtil.pagination_datetime(params[:page])
          fans = Follow.paginate_fans(user.id, min_created_at)
          [fans,
            V1::FollowWrapper.fans_data(fans, params[:current_user_id])]
        else
          ErrorCode.error_content(:user_not_existed)
        end

      end

      def send_captcha(cellphone)
        return ErrorCode.error_content(:cellphone_is_blank) if cellphone.blank?

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
        captcha, content = validate_captcha(params[:cellphone], params[:code])
        return [captcha, content] unless captcha

        if !Util::ValidateUtil.valid_pwd?(params[:password])
          ErrorCode.error_content(:password_is_invalid)
        elsif !Util::ValidateUtil.valid_pwd_length?(params[:password])
          ErrorCode.error_content(:password_length_invalid)
        else
          user = User.register_by_cellphone(captcha, params[:password])
          UserWorker.delay.register_device_info(user.id, params[:device_type],
            params[:device_id], params[:device_token])
          [user, V1::UserWrapper.user_detail(user)]
        end
      end

      def signin(params)
        return ErrorCode.error_content(:cellphone_is_blank) if params[:cellphone].blank?

        user = User.fetch_by_cellphone(params[:cellphone])
        if user.present?
          if user.valid_password?(params[:password])
            UserWorker.delay.register_device_info(user.id, params[:device_type],
              params[:device_id], params[:device_token])
            [user, V1::UserWrapper.user_detail(user, true)]
          else
            ErrorCode.error_content(:user_password_error)
          end
        else
          ErrorCode.error_content(:user_not_existed)
        end
      end

      def update_profile(params)
        current_user = User.fetch_by_id(params[:current_user_id])

        if params[:name].present?
          unless Util::ValidateUtil.valid_name?(params[:name])
            return ErrorCode.error_content(:username_invalid)
          end

          unless Util::ValidateUtil.valid_name_length?(params[:name])
            return ErrorCode.error_content(:username_invalid_length)
          end

          user = User.fetch_by_name(params[:name])
          if user.present? && user.id != current_user.id
            return ErrorCode.error_content(:username_existed)
          end
        end

        if current_user.refresh_user(params)
          [current_user, V1::UserWrapper.user_detail(current_user)]
        else
          ErrorCode.error_content(:user_update_error)
        end
      end

      def forgot_password(cellphone)
        return ErrorCode.error_content(:cellphone_is_blank) if cellphone.blank?

        user = User.fetch_by_cellphone(cellphone)
        if user.present?
          captcha = Captcha.build_captcha(cellphone)
          if captcha
            UserWorker.delay.deliver_cellphone_captcha(captcha)
            [captcha, {success: true}]
          else
            ErrorCode.error_content(:captcha_limit_count)
          end
        else
          ErrorCode.error_content(:cellphone_not_existed)
        end
      end

      def reset_password(params)
        captcha, content = validate_captcha(params[:cellphone], params[:code])
        return [captcha, content] unless captcha

        if !Util::ValidateUtil.valid_pwd?(params[:password])
          ErrorCode.error_content(:password_is_invalid)
        elsif !Util::ValidateUtil.valid_pwd_length?(params[:password])
          ErrorCode.error_content(:password_length_invalid)
        elsif params[:password] != params[:confirm_password]
          ErrorCode.error_content(:confirm_password_invalid)
        else
          user = User.reset_password(captcha, params[:password])
          [user, V1::UserWrapper.user_detail(user, true)]
        end
      end

      private

        def validate_captcha(cellphone, code)
          captcha = Captcha.fetch_code(cellphone)
          if captcha.present?
            if captcha.expired?
              ErrorCode.error_content(:captcha_is_expired)
            elsif !captcha.valid_code?(code)
              ErrorCode.error_content(:captcha_is_invalid)
            else
              [captcha, true]
            end
          else
            ErrorCode.error_content(:cellphone_not_existed)
          end
        end

    end

  end
end