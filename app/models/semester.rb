# == Schema Information
#
# Table name: semesters
#
#  id            :integer          not null, primary key
#  class_year_id :integer          not null
#  identifier    :string           not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Semester < ActiveRecord::Base
  belongs_to :class_year
  has_and_belongs_to_many :subjects

  validates(:identifier) { presence; uniqueness(scope: :class_year_id); format(with: /[1-6][ab]/) }
end
