# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  title_ja   :string(255)      not null
#  title_en   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  sequence(:title_ja) { |n| "生理学_#{n}" }
  sequence(:title_en) { |n| "physiology_#{n}" }

  factory :subject do
    title_ja
    title_en
  end
end
