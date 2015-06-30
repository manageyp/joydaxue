# -*- coding: utf-8 -*-

module V1
  class BaseApi < Grape::API

    def self.inherited(subclass)
      super

      subclass.instance_eval do
        helpers V1::Helpers
        #version 'v1'
        prefix 'v1'
      end
    end

  end
end
