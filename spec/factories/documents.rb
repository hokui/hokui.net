# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  subject_id :integer          not null
#  class_year :integer          not null
#  code       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :document do
    subject_id 1
    class_year 93
    code       1
  end
end
