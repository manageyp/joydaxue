# == Schema Information
#
# Table name: user_devices
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  client_type  :string(255)      not null
#  device_id    :integer          not null
#  device_name  :string(255)
#  device_agent :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_device do
    id 1
    user_id 1
    client_type "ios"
    device_id 1
    device_name "iphone"
    device_agent "MyString"
  end
end
