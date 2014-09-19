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

  validates(:year) { presence; uniqueness; numericality(greater_than: 2014, less_than: 2074) }

  before_validation :reform_class_year_to_year

  private

  def reform_class_year_to_year
    if 90 < self.year && self.year < 150
      self.year = 1924 + self.year
    end
  end
end
