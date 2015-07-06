module V1
  class UserWrapper

    class << self

      def user_detail(user)
        {
          user_id: user.id,
          name: user.name,
          sex: user.sex
        }
      end

    end

  end
end