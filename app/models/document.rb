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

class Document < ActiveRecord::Base
  belongs_to :subject

  validates(:subject_id) { presence }
  validates(:class_year) { presence }
  validates(:code)       { presence; uniqueness(scope: [:subject_id, :class_year]) }
end
