class SchoolIntroduction < ActiveRecord::Base
  belongs_to :school

  ModelName = "学校介绍"
  ColumnNames ={
    school_id: "学校ID",
    short_content: "简单描述",
    full_content: "详细描述"
  }

end
