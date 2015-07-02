module V1
  class UserWrapper

    class << self

      def user_detail(user, current_user_id)
        # TODO friendship with current_user
        {
          user_id: user.id,
          name: user.name,
          sex: user.sex
        }
      end

    end

  end
end