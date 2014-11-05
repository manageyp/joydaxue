class User < ActiveRecord::Base

  ModelName = "用户"
  ColumnNames = {
    name: "名称",
    email: "邮箱",
    cellphone: "手机号",
    display_name: "中文名称",
    sex: "性别",
    status: "状态",
    memo: "备注"
  }

end
