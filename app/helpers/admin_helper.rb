# -*- coding: utf-8 -*-

module AdminHelper

  def resource_name
    name = controller.controller_name
    Util::AdminResources::RESOURCES[name.to_sym] if name.present?
  end

  def header_notice
    action_name = params[:action]
    case action_name
    when 'index'
      "#{resource_name}列表--Joydaxue 后台"
    when 'show'
      "#{@record.name}详情--Joydaxue 后台"
    when 'edit'
      "编辑#{@record.name}--Joydaxue 后台"
    else
      "Joydaxue 后台"
    end
  end

  def active_css(controller_name)
    name = controller.controller_name
    "active" if name == controller_name
  end

  def active_collapse(names)
    name = controller.controller_name
    "in" if names.include?(name)
  end

  def chinese_datetime(value)
    if value.present?
      value.strftime("%Y年%m月%d日 %H时:%M分:%S秒")
    end
  end

  def simple_today(value=Date.today)
    value.strftime("%Y-%m-%d")
  end

  def direct_delete_action(record)
    name = controller.controller_name
    url = "/admin/#{name}/#{record.id}"
    link_to("<i class='fa fa-trash-o'></i>".html_safe, "javascript:void(0)", onclick: "deleteResourceBtn('#{url}', #{record.id})", title: "删除")
  end

  def district_word(code)
    if code.present?
      District.code_to_name(code)
    else
      "无"
    end
  end

  def select_choices_for(objs)
    objs.map{|k,v| [k.to_s,v]}
  end

  def select_tag_options_for(objs, options={})
    choices = select_choices_for(objs)
    ret = []
    ret << "<option value="">#{options[:name]}</option>"
    ret << "<option value=""></option>"
    choices.each do |it|
      ret << "<option value='#{it[0]}' #{options[:selected]==it[0].to_s ? "selected" : nil} >#{it[1]}</option>"
    end
    ret.join(" ").html_safe
  end

  def status_info(record)
    if record.is_active?
      "<span class='label bg-success'>#{record.status_word}</span>".html_safe
    else
      "<span class='label bg-danger'>#{record.status_word}</span>".html_safe
    end
  end

  def change_log_button(detail)
    url = "/admin/change_logs?detail_type=#{detail.class.name}&detail_id=#{detail.id}"
    link_to("查看修改历史", "javascript:void(0)", onclick: "showChangeLog('#{url}')", title: "查看修改历史")
  end

  def notice_display(content)
    content.present? ? 'block' : 'none'
  end

  def permission_checkbox(role_id, controller_name, action_name)
    if role_id.present? && Permission.permit_controller_action?(role_id, controller_name, action_name)
      checked = "checked"
      checked_attribute = "checked='checked'"
    end
    "<input type='checkbox' #{checked_attribute} class='checkbox' name='#{controller_name}-#{action_name}'><i class='fa fa-check-square-o #{checked}'></i> #{action_name}".html_safe
  end

end