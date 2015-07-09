# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe UserApi do

    before(:each) do
      @user = create(:user)
      @user_alice = create(:user_alice)
      @user_token = create(:user_token)
      @captcha = create(:captcha)
      @reset_captcha = create(:reset_captcha)
      @new_cellphone = "15099999999"
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
        resp_data["data"]["token"].should_not be_nil
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

      it "should not do users send_captcha cellphone existed" do
        post "/v1/users/send_captcha", cellphone: @user.cellphone
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1022"
      end

      it "should not do users send_captcha cellphone invalid format" do
        post "/v1/users/send_captcha", cellphone: "123456"
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1023"
      end
    end


    describe "POST api /v1/users/signup" do
      it "should do users signup" do
        post "/v1/users/signup", cellphone: @captcha.cellphone,
          code: @captcha.code, password: '123456'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["user_id"].should_not be_nil
        resp_data["data"]["name"].should_not be_nil
        resp_data["data"]["token"].should_not be_nil
      end

      it "should not users signup wrong cellphone" do
        post "/v1/users/signup", cellphone: @new_cellphone,
          code: @captcha.code, password: '123456'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1024"
      end

      it "should not do users signup wrong code" do
        post "/v1/users/signup", cellphone: @captcha.cellphone,
          code: 'wrong', password: '123456'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1013"
      end

      it "should not do users signup invalid password" do
        post "/v1/users/signup", cellphone: @captcha.cellphone,
          code: @captcha.code, password: '1'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1016"
      end
    end


    describe "POST api /v1/users/signin" do
      it "should do users signin by cellphone" do
        post "/v1/users/signin", cellphone: @user.cellphone, password: '123456'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["user_id"].should_not be_nil
        resp_data["data"]["name"].should_not be_nil
        resp_data["data"]["token"].should_not be_nil
      end

      it "should do users signin by name" do
        post "/v1/users/signin", cellphone: @user.cellphone, password: '123456'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["data"]["name"].should_not be_nil
      end

      it "should not do users signin wrong cellphone" do
        post "/v1/users/signin", cellphone: 'wrong@qq.com', password: 'wrong'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1019"
      end

      it "should not do users signin wrong password" do
        post "/v1/users/signin", cellphone: @user.cellphone, password: 'wrong'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1018"
      end
    end


    describe "POST api /v1/users/update_profile" do
      it "should do users update_profile" do
        post "/v1/users/update_profile", token: @user_token.token,
          name: "new_user_name", sex: 0
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("0000")
        expect(resp_data["data"]["user_id"]).to eq(@user.id)
        expect(resp_data["data"]["name"]).to eq("new_user_name")
        expect(resp_data["data"]["sex"]).not_to eq(@user.sex)
        expect(resp_data["data"]["sex"]).to eq(0)
        expect(resp_data["data"]["token"]).not_to eq(nil)
      end

      it "should not do users update_profile because invalid token" do
        post "/v1/users/update_profile", name: @user.name
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1003"
      end

      it "should not do users update_profile because expired token" do
        post "/v1/users/update_profile", token: "expired token", name: @user.name
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1004"
      end

      it "should not do users update_profile because invalid username" do
        post "/v1/users/update_profile", token: @user_token.token, name: 'abc@123'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1005"
      end

      it "should not do users update_profile because invalid username length" do
        post "/v1/users/update_profile", token: @user_token.token, name: 'a'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1006"
      end

      it "should not do users update_profile because duplicated username" do
        post "/v1/users/update_profile", token: @user_token.token, name: @user_alice.name
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "1025"
      end
    end


    describe "POST api /v1/users/forgot_password" do
      it "should do users forgot_password" do
        post "/v1/users/forgot_password", cellphone: @user.cellphone
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("0000")
        expect(resp_data["data"]["success"]).to eq(true)
      end

      it "should not do users forgot_password with blank cellphone" do
        post "/v1/users/forgot_password"
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1021")
      end

      it "should not users forgot_password with wrong cellphone" do
        post "/v1/users/forgot_password", cellphone: "12345678912"
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1024")
      end

      it "should not do users forgot_password because reach limit count" do
        Captcha.stub(:valid_today_count?) { false }
        post "/v1/users/forgot_password", cellphone: @user.cellphone
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1020")
      end
    end


    describe "POST api /v1/users/reset_password" do
      it "should do users reset_password" do
        post "/v1/users/reset_password", cellphone: @reset_captcha.cellphone,
          code: @reset_captcha.code, password: '123456', confirm_password: '123456'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("0000")
        expect(resp_data["data"]["user_id"]).to eq(@user.id)
      end

      it "should not users reset_password wrong cellphone" do
        post "/v1/users/reset_password", cellphone: @user_alice.cellphone,
          code: @reset_captcha.code
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1024")
      end

      it "should not do users reset_password wrong code" do
        post "/v1/users/reset_password", cellphone: @reset_captcha.cellphone,
          code: 'wrong'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1013")
      end

      it "should not do users reset_password invalid password" do
        post "/v1/users/reset_password", cellphone: @reset_captcha.cellphone,
          code: @reset_captcha.code, password: '1'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1016")
      end

      it "should not do users reset_password invalid confirm password" do
        post "/v1/users/reset_password", cellphone: @reset_captcha.cellphone,
          code: @reset_captcha.code, password: '123456', confirm_password: '123'
        response.status.should == 201
        resp_data = JSON.parse(response.body)
        expect(resp_data["status"]).to eq("1017")
      end
    end

  end
end