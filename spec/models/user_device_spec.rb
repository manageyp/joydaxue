# == Schema Information
#
# Table name: user_devices 用户设备
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null  用户 ID
#  device_type  :string(255)                设备类型
#  device_id    :string(255)      not null  设备 ID
#  device_token :string(255)                设备推送 Token
#  status       :integer                    设备的状态
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe UserDevice, :type => :model do

  before(:each) do
    @user = create(:user)
    @user_device = create(:user_device)
  end

  context "scopes" do
    describe ".active" do

      it "returns active users" do
        expect(UserDevice.active).to match_array [@user_device]
      end

    end
  end


  describe "#is_ios" do
    it "should be ios device" do
      expect(@user_device.is_ios?).to eq(true)
    end
  end


  describe ".push_device" do
    it "should get user latest push device" do
      device = UserDevice.push_device(@user.id)
      expect(device).to eq(@user_device)
    end
  end


  describe ".register_device" do
    it "should build user device" do
      expect {
        device = UserDevice.register_device(@user.id, 'ios', 'device-2', 'device-token-2')

        expect(device.id).not_to eq(nil)
      }.to change { UserDevice.count }.by(1)
    end
  end

end
