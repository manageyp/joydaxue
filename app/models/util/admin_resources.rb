module Util
  class AdminResources

    RESOURCES = {
      schools: "学校",
      users: "用户",
      roles: "角色",
      user_roles: "用户角色",
      permissions: "权限配置",
      user_devices: "用户设备"
    }

    class << self

      def admin_routes(refresh=false)
        # TODO use cache, and refresh cache manully
        routes_to_display = Rails.application.routes.routes.collect do |route|
          ActionDispatch::Routing::RouteWrapper.new(route)
        end.reject do |route|
          route.internal?
        end.collect do |route|
          route.reqs if route.reqs.index('admin/')
        end.compact!.uniq!

        collect_routes(routes_to_display)
      end

      def collect_routes(routes)
        ret = {}
        routes.each do |route|
          slash = route.index('/')
          number = route.index('#')
          controller_name = route[slash + 1, number - slash - 1]
          action_name = route[number + 1, route.size]
          if ret.has_key?(controller_name)
            ret[controller_name] << action_name
          else
            ret[controller_name] = [action_name]
          end
        end
        ret
      end

    end

  end
end