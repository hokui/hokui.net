FactoryGirl.define do
  factory :news do
    sequence(:text) { |n| "news_#{n}" }
  end
end
