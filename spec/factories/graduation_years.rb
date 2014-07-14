# == Schema Information
#
# Table name: graduation_years
#
#  id         :integer          not null, primary key
#  year       :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :graduation_year do
    year 1
  end
end
