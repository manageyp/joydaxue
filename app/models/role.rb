class Role < ActiveRecord::Base

  ModelName = "角色"
  ColumnNames = {
    name: "名称",
    description: "描述",
    status: "状态"
  }

end
