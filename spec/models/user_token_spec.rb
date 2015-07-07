# == Schema Information
#
# Table name: user_tokens  用户 Token
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null  用户 ID
#  token      :string(191)      Token 值，32 位 Base64 字符
#  expired_at :datetime         Token 过期时间
#  created_at :datetime
#  updated_at :datetime

require 'rails_helper'

RSpec.describe UserToken, :type => :model do

  before(:each) do
    @user = create(:user)
    @user_token = create(:user_token)
    @user_alice = create(:user_alice)
  end

  context "when user token not exist" do
    before(:each) do
      @invalid_token = "invalid_token"
    end

    it "fetch_token should create user token" do
      lambda {
        new_token = UserToken.fetch_token(@user_alice.id)
        expect(new_token.valid_token?).to eq(true)
      }.should change(UserToken, :count)
    end

    it "create_token should create" do
      lambda {
        new_token = UserToken.create_token(@user_alice.id)
        expect(new_token.valid_token?).to eq(true)
       }.should change(UserToken, :count)
    end

    it "verify_token should be false" do
      expect(UserToken.verify_token(@invalid_token)).to eq(nil)
    end
  end


  context "when token exist and valid" do
    it "should be a valid_token" do
      expect(@user_token.valid_token?).to eq(true)
    end

    it "should need not to refresh token" do
      expect(@user_token.need_refresh?).to eq(false)
    end

    it "should need to refresh token" do
      @user_token.update_attributes(expired_at: 2.hours.from_now)
      expect(@user_token.need_refresh?).to eq(true)
    end

    it "should fetch user user token" do
      expect(UserToken.fetch_token(@user.id)).to eq(@user_token)
    end

    it "should refresh user token" do
      old_expired_at = @user_token.expired_at
      expect(@user_token.refresh_expired_at).to eq(true)
      expect(@user_token.expired_at).to be > old_expired_at
    end

    it "should force refresh user token" do
      new_token = UserToken.fetch_token(@user.id, true)
      expect(new_token.token).not_to eq(@user_token.token)
    end

    it "verify_token should be true" do
      expect(UserToken.verify_token(@user_token.token)).to eq(@user_token)
    end
  end


  context "when token exist but invalid" do
    before(:each) do
      @user_token.update_attributes(expired_at: 7.days.ago.to_date)
    end

    it "should not be a valid_token" do
      expect(@user_token.valid_token?).to eq(false)
    end

    it "should not need to refresh token" do
      expect(@user_token.need_refresh?).to eq(false)
    end

    it "should not verify user token" do
      expect(UserToken.verify_token(@user_token.token)).to eq(nil)
    end
  end


  context "should call private method to generate token" do
    it "should generate token" do
      expect(UserToken.send(:generate_token)).not_to eq(nil)
    end
  end

end
