# -*- coding: utf-8 -*-

module V1
  module Helpers

    include Util::GrapeCache

    def set_datetime_pagination(records, datetime)
      if records.present?
        ret = {
          total_count: records.total_count,
          per_page: records.limit_value,
          total_pages: records.total_pages,
          prev_page: records.prev_page || ""
        }

        if params[:page].present?
          ret[:current_page] = 2
        else
          ret[:current_page] = records.current_page
        end

        if records.next_page
          ret[:next_page] = records.last.try(datetime)
        end

        ret
      end
    end

    def render_datetime_pagination(records, content, datetime = :created_at)
      status = '0000'
      message = route.route_description || ''
      data = content || {}
      pagination = set_datetime_pagination(records, datetime)

      { status: status, message: message, data: data, pagination: pagination }
    end

    def render_or_cache(options = {})
      status = options[:status] || '0000'
      message = options[:message] || route.route_description || ''
      data = options[:data] || {}

      set_grape_cache(etag: data)

      { status: status, message: message, data: data }
    end

    def render_json(options = {})
      status = options[:status] || '0000'
      message = options[:message] || route.route_description || ''
      data = options[:data] || {}
      { status: status, message: message, data: data }
    end

    def render_error(msg_code)
      status = msg_code.first
      message = msg_code.last
      { status: status, message: message, data: {} }
    end

    def require_token?
      route.route_params.keys.include?('token')
    end

    def correct_http_status
      case request.request_method.to_s.upcase
      when 'POST'
        201
      else
        200
      end
    end

    def validate_user_token
      return unless require_token?

      if params[:token].blank?
        content = ErrorCode.error_value(:user_token_invalid)
        error!(render_error(content), correct_http_status)
      else
        user_token = UserToken.verify_token(params[:token])
        if user_token
          params[:current_user_id] = user_token.user_id
        else
          content = ErrorCode.error_value(:user_token_expired)
          error!(render_error(content), correct_http_status)
        end
      end
    end

    def parse_user_token
      if params[:token].present?
        user_token = UserToken.verify_token(params[:token])
        if user_token
          params[:current_user_id] = user_token.user_id
        end
      end
    end

    def parse_real_ip
      params[:real_ip] = request.env['HTTP_X_REAL_IP']
    end

  end
end

