# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe FollowApi do

    before(:each) do
      @user = create(:user)
      @user_alice = create(:user_alice)
      @user_token = create(:user_token)
    end

    describe "POST api /v1/follows" do
      it "should do follow user" do
        old_count = Follow.count
        post "/v1/follows", token: @user_token.token, user_id: @user_alice.id
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["success"].should == true
        Follow.count.should == (old_count + 1)
      end

      it "should not do follow user with wrong user_id" do
        post "/v1/follows", token: @user_token.token, user_id: "999"
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1019"
      end
    end

    describe "POST api /v1/follows/cancel" do
      it "should do unfollow user" do
        create(:follow)
        old_count = Follow.count
        post "/v1/follows/cancel", token: @user_token.token, user_id: @user_alice.id
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["success"].should == true
        Follow.count.should == (old_count - 1)
      end

      it "should not do unfollow user with wrong user_id" do
        post "/v1/follows/cancel", token: @user_token.token, user_id: "999"
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1019"
      end
    end

  end
end
