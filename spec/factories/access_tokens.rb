# == Schema Information
#
# Table name: access_tokens
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  token            :string(255)      not null
#  last_activity_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_token do
    user_id 1
    token "MyString"
    last_activity_at "2014-07-18 09:53:04"
  end
end
