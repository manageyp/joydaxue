# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe FavoriteApi do

    before(:each) do
      create(:user)
      create(:favorite)
      @school = create(:school)
      @user_token = create(:user_token)
      @favorite_id = "school:#{@school.id}"
      @new_favorite_id = "school:2"
    end

    describe "POST api /v1/favorites" do
      it "should post  favorites" do
        old_count = Favorite.count
        post "/v1/favorites", token: @user_token.token, favorite_id: @new_favorite_id
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["favorite_id"].should == @new_favorite_id
        resp_data["data"]["is_favorite"].should == true
        Favorite.count.should == (old_count + 1)
      end
    end

    describe "POST api /v1/favorites/cancel" do
      it "should not do favorites cancel because collection does not exist " do
        post "/v1/favorites/cancel", token: @user_token.token, favorite_id: @favorite_id
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["favorite_id"].should == @favorite_id
        resp_data["data"]["is_favorite"].should == false
      end
    end

  end
end
