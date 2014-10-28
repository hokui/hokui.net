# == Schema Information
#
# Table name: semesters
#
#  id            :integer          not null, primary key
#  class_year_id :integer          not null
#  identifier    :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :semester do
    id 1
    class_year_id 1
    identifier "2a"
  end
end
