# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe SchoolApi do

    before(:each) do
      @school = create(:school)
    end

    describe "GET api /v1/schools" do
      it "should get schools" do
        get "/v1/schools"
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"][0]["school_id"].should_not be_nil
        resp_data["data"][0]["name"].should_not be_nil
      end
    end

    describe "GET api /v1/schools/id" do
      it "should not get school detail with wrong id" do
        get "/v1/schools/500"
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "2001"
      end

      it "should get school detail" do
        get "/v1/schools/#{@school.id}"
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["school_id"].should_not be_nil
        resp_data["data"]["name"].should_not be_nil
      end
    end

  end
end