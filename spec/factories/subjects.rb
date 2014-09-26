# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  title_ja   :string(255)
#  title_en   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :subject do
    title_ja "生理学Ⅰ"
    title_en "physiology_1"
  end
end
