class School < ActiveRecord::Base

  ModelName = "学校"
  ColumnNames = {
    province_id: "所属省份",
    city_id: "所属城市",
    name: "名称",
    address: "地址",
    avatar: "头像",

    college_type: "院校类别",
    telephone: "联系电话",
    website: "网址",
    found_year: "创建年份",
    zipcode: "邮政编码",
    affiliate: "院校隶属于",

    latitude: "纬度",
    longitude: "经度",

    is_211: "是否 211",
    is_985: "是否 985",
    is_edu_affiliate: "是否教育部直属院校",
    has_bachelor: "设立研究生院",
    is_independent: "独立学院",
    is_civilian_run: "民办院校",

    key_disciplines: "国家重点学科",
    master_num: "硕士点",
    phd_num: "博士点",
    academician_num: "院士人数"
  }

end
