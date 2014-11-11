class SchoolPhoto < ActiveRecord::Base

  belongs_to :school

  ModelName = "学校相册"
  ColumnNames ={
    school_id: "学校ID",
    image: "图片地址",
    position: "图片排序"
  }

end
