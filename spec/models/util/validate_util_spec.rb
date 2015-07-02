# -*- encoding : utf-8 -*-

require 'spec_helper'

module Util
  describe ValidateUtil do

    describe "Validate user name regexp expretion" do
      it "should be correct user name" do
        expect(Util::ValidateUtil.valid_name?("henry_123哈哈")).to eq(0)
      end

      it "should not be correct user name with emoji" do
        expect(Util::ValidateUtil.valid_name?("😄henry")).to eq(nil)
      end

      it "should not be correct user name with slash" do
        expect(Util::ValidateUtil.valid_name?("h/enry")).to eq(nil)
      end
    end

    describe "Validate user password regexp expretion" do
      it "should be correct password" do
        expect(Util::ValidateUtil.valid_pwd?("abc_123")).to eq(0)
      end

      it "should not be correct password with emoji" do
        expect(Util::ValidateUtil.valid_pwd?("😄henry")).to eq(nil)
      end

      it "should not be correct password with at" do
        expect(Util::ValidateUtil.valid_pwd?("h@enry")).to eq(nil)
      end
    end

    describe "Validate user email regexp expretion" do
      it "should be correct email" do
        expect(Util::ValidateUtil.valid_email?("manageyp@gmail.com")).to eq(0)
      end

      it "should not be correct email with wrong string" do
        expect(Util::ValidateUtil.valid_email?("manageyp")).to eq(nil)
      end

      it "should not be correct email with at" do
        expect(Util::ValidateUtil.valid_email?("h@enry")).to eq(nil)
      end
    end

    describe "Validate user cellphone regexp expretion" do
      it "should be correct cellphone" do
        expect(Util::ValidateUtil.valid_cellphone?("18888888888")).to eq(0)
      end

      it "should not be correct cellphone with wrong string" do
        expect(Util::ValidateUtil.valid_cellphone?("19912345678")).to eq(nil)
      end

      it "should not be correct cellphone with at" do
        expect(Util::ValidateUtil.valid_cellphone?("123456")).to eq(nil)
      end
    end

  end
end