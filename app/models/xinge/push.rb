# -*- coding: utf-8 -*-

module Xinge
  class Push

    class << self

      def do_push(user_id, content)
        title = "App Name"
        device = UserDevice.push_device(user_id)
        if device.present?
          if device.is_ios? && device.device_token.present?
            Xinge::Ios.push_to_single_device(device.device_token, title, content)
          else
            Xinge::Android.push_to_single_device(device.device_token, title, content)
          end
        end
      end

    end

  end
end