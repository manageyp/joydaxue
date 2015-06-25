# == Schema Information
#
# Table name: permissions 授权
#
#  id              :integer          not null, primary key
#  role_id         :integer          not null  角色 ID
#  controller_name :string(255)                Controller 名称
#  action_names    :string(255)                Controller 内允许访问的 action 名称
#  created_at      :datetime
#  updated_at      :datetime
#

class Permission < ActiveRecord::Base
  belongs_to :role

  def refresh_permission(params)
    self.role_id = params[:role_id] if params[:role_id].present?
    self.controller_name = params[:controller_name] if params[:controller_name].present?
    self.action_names = params[:action_names] if params[:action_names].present?
    self.save
  end

  class << self

    def permitted?(user, controller_name, action_name)
      user_role = user.user_role
      if user_role
        permit_controller_action?(user_role.role_id, controller_name, action_name) ||
        permit_all_actions?(user_role.role_id, controller_name) ||
        permit_all_controllers?(user_role.role_id)
      end
    end

    def permit_controller_action?(role_id, controller_name, action_name)
      record = where(role_id: role_id, controller_name: controller_name).first
      record && record.action_names.index(action_name)
    end

    def permit_all_actions?(role_id, controller_name)
      exists?(role_id: role_id, controller_name: controller_name, action_names: 'all')
    end

    def permit_all_controllers?(role_id, controller_name, action_name)
      exists?(role_id: role_id, controller_name: 'controllers', action_names: 'all')
    end

    def parse_action_names(action_names)
      controllers = {}
      action_names.each do |action_name|
        controller_name, action_name = action_name.split('-')
        if controllers.has_key?(controller_name)
          controllers[controller_name] << ";#{action_name}"
        else
          controllers[controller_name] = action_name
        end
      end
      controllers
    end

    def build_permissions(role_id, action_names)
      Permission.transaction do
        Permission.where(role_id: role_id).delete_all
        controllers = parse_action_names(action_names)
        controllers.each do |controller_name, names|
          Permission.create(role_id: role_id, controller_name: controller_name,
            action_names: names)
        end
      end
    end

  end

end
