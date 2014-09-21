# == Schema Information
#
# Table name: class_years
#
#  id         :integer          not null, primary key
#  year       :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class ClassYear < ActiveRecord::Base
  has_many :users

  validates(:year) { presence; uniqueness; numericality(greater_than: 90, less_than: 150) }
end
