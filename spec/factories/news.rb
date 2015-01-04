FactoryGirl.define do
  factory :news do
    sequence(:title) { |n| "news_title_#{n}" }
    sequence(:text) { |n| "news_#{n}" }
  end
end
