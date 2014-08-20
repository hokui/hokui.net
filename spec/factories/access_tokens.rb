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
    user_id          1
    token            "4ebbcf209ca3625dfe0b2595d627ffacd90f8cefd69722712a451a7c291643af"
    last_activity_at "2014-07-18 09:53:04"
  end
end
