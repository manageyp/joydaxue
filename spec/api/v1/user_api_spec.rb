# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe UserApi do

    before(:each) do
      @user = create(:user)
      @captcha = create(:captcha)
    end

    describe "GET api /v1/users/id" do
      it "should not get user detail with wrong id" do
        get "/v1/users/500"
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1019"
      end

      it "should get user detail" do
        get "/v1/users/#{@user.id}"
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["user_id"].should_not be_nil
        resp_data["data"]["name"].should_not be_nil
      end
    end

    describe "POST api /v1/users/send_captcha" do
      it "should do users send_captcha" do
        post "/v1/users/send_captcha", cellphone: @captcha.cellphone
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["success"].should == true
      end

      it "should not do users send_captcha email existed" do
        post "/v1/users/send_captcha", cellphone: @user.cellphone
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1022"
      end

      it "should not do users send_captcha email invalid format" do
        post "/v1/users/send_captcha", cellphone: "123456"
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1023"
      end
    end

  end
end