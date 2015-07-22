# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe MessageApi do

    before(:each) do
      @user = create(:user)
      @user_alice = create(:user_alice)
      @user_token = create(:user_token)
      @message = create(:message)
      @pair_message = create(:pair_message)
    end

    describe "GET api /v1/messages" do
      it "should list user messages with token" do
        get "/v1/messages", token: @user_token.token
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"][0]["message_id"].should == @pair_message.id
        resp_data["data"][0]["created_at"].should_not be_nil
        resp_data["data"][0]["sender"]["user_id"].should == @user_alice.id
        resp_data["pagination"]["current_page"].should == 1
      end
    end

    describe "GET api /v1/messages/unread" do
      it "should get user unread message count with token" do
        get "/v1/messages/unread", token: @user_token.token
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["Follow"].should_not be_nil
      end
    end

    describe "POST api /v1/messages/delete" do
      it "should delete user message with token" do
        post "/v1/messages/delete", token: @user_token.token, message_id: @pair_message.id
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["success"].should == true
      end

      it "should not delete user message with wrong id" do
        post "/v1/messages/delete", token: @user_token.token, message_id: 999
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1050"
      end

      it "should not delete user message with wrong token" do
        post "/v1/messages/delete", token: @user_token.token, message_id: @message.id
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1051"
      end
    end

  end
end
