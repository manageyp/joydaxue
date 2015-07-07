module V1
  class UserWrapper

    class << self

      def user_detail(user, force_refresh = false)
        ret = { user_id: user.id,
          name: user.name,
          sex: user.sex }

        user_token = UserToken.fetch_token(user.id, force_refresh)
        if user_token
          ret[:token] = user_token.token
        end

        ret
      end

    end

  end
end