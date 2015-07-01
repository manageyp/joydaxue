# -*- encoding : utf-8 -*-

class BaseWrapper

  class << self
    def has_value?(value)
      value && !value.blank?
    end

    def has_size?(value)
      value && value.size > 0
    end

    def small_image(image_url)
      "#{image_url}!100X100" if image_url.present?
    end

    def medium_image(image_url)
      "#{image_url}!300X300" if image_url.present?
    end

    def large_image(image_url)
      "#{image_url}!800X800" if image_url.present?
    end

  end

end