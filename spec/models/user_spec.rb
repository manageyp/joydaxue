# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  email        :string(255)      not null
#  cellphone    :string(255)      not null
#  sex          :integer
#  follows_count    :integer(11)  default(0) 用户关注人数
#  fans_count       :integer(11)  default(0) 用户粉丝人数
#  status       :integer          default(0)
#  memo         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { FactoryGirl.create(:user) }


  context "validations" do
    it "requires unique name" do
      expect(user).to validate_uniqueness_of(:name)
    end

    it "requires unique name" do
      expect(user).to validate_presence_of(:name)
    end

    it "requires unique cellphone" do
      expect(user).to validate_uniqueness_of(:cellphone)
    end
  end


  context "associations" do
    it { should have_one(:user_role) }

    it { should have_many(:user_devices) }
  end


  context "scopes" do
    describe ".active" do

      it "returns active users" do
        expect(User.active).to match_array [user]
      end

    end
  end


  describe "#refresh_user" do
    it "should refresh user name" do
      params = { name: 'alice' }
      user.refresh_user(params)
      expect(user.name).to eq(params[:name])
    end
  end


  describe ".build_user" do
    it "should build user succeed" do
      expect {
        params = { name: 'alice', email: 'alice@qq.com', cellphone: '18888888888' }
        new_user = User.build_user(params)

        expect(new_user.captcha_number).not_to eq(nil)
      }.to change { User.count }.by(1)
    end
  end

end
