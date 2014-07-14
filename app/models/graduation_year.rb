# == Schema Information
#
# Table name: graduation_years
#
#  id         :integer          not null, primary key
#  year       :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class GraduationYear < ActiveRecord::Base
  has_many :users
end
