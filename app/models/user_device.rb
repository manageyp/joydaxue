class UserDevice < ActiveRecord::Base

  ModelName = "用户设备"
  ColumnNames = {
    user_id: "用户 ID",
    client_type: "客户端类型",
    device_id: "设备 UID",
    device_name: "设备名称",
    device_agent: "设备 Agent 信息"
  }

end
