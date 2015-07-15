# == Schema Information
#
# Table name: captchas
#
#  id           :integer          not null, primary key
#  captcha_type :string(255)      not null
#  mobile       :string(255)      not null
#  send_count   :integer          default(0)
#  code         :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Captcha, :type => :model do

  before(:each) do
    @captcha = create(:captcha)
    @user_alice = create(:user_alice)
  end


  describe "#valid_code?" do
    it "should be valid captcha code" do
      expect(@captcha.valid_code?(@captcha.code)).to eq(true)
    end

    it "should not be valid captcha code" do
      expect(@captcha.valid_code?("wrong")).to eq(false)
    end
  end


  describe "#expired?" do
    it "should be expired captcha" do
      @captcha.update_attributes(updated_at: 2.hours.ago)
      expect(@captcha.expired?).to eq(true)
    end

    it "should not be expired captcha" do
      expect(@captcha.expired?).to eq(false)
    end
  end


  describe "#send_frequent?" do
    it "should be send_frequent captcha" do
      @captcha.touch
      expect(@captcha.send_frequent?).to eq(true)
    end

    it "should not be expired captcha" do
      expect(@captcha.send_frequent?).to eq(false)
    end
  end


  describe ".fetch_code" do
    it "should fetch captcha code with cellphone" do
      captcha = Captcha.fetch_code(@captcha.cellphone)
      expect(captcha.id).to eq(@captcha.id)
    end
  end


  describe ".fetch_captcha" do
    it "should fetch captcha with cellphone and code" do
      captcha = Captcha.fetch_captcha(@captcha.cellphone, @captcha.code)
      expect(captcha.id).to eq(@captcha.id)
    end
  end


  describe ".build_captcha" do
    it "should build new captcha" do
      expect {
        captcha = Captcha.build_captcha(@user_alice.cellphone)

        expect(captcha.code).not_to eq(nil)
      }.to change { Captcha.count }.by(1)
    end
  end

end
