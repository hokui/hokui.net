# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

FactoryGirl.define do
  factory :news do
    sequence(:title) { |n| "news_title_#{n}" }
    sequence(:text) { |n| "news_#{n}" }
  end
end
