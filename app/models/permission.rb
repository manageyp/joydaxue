class Permission < ActiveRecord::Base

  ModelName = "授权"
  ColumnNames = {
    role_id: "角色 ID",
    controller_name: "Controller 名称",
    action_name: "Controller 内 action 名称"
  }

end
