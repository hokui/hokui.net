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
  has_many :semesters

  validates(:year) { presence; uniqueness; numericality(greater_than: 90, less_than: 150) }

  after_create :register_ml_list!

  def register_ml_list!
    list = MailingList::List.create!(
      name: self.year
    )
    self.ml_list_id = list.id
    self.save!
  end
end
