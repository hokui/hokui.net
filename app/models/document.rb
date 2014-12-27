# == Schema Information
#
# Table name: documents
#
#  id             :integer          not null, primary key
#  subject_id     :integer          not null
#  user_id        :integer          not null
#  class_year     :integer          not null
#  document_type  :integer          not null
#  number         :integer          default("1"), not null
#  page           :integer          default("1"), not null
#  with_answer    :boolean
#  note           :string
#  download_count :integer          default("0"), not null
#  file_name      :string           not null
#  file_mime      :string           not null
#  file_sha1      :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Document < ActiveRecord::Base
  # NOTE Attribute `class_year` is not a reference to an instance of ClassYear,
  # but the actual number of class year to which the document was distributed.

  belongs_to :subject
  belongs_to :user

  validates(:subject_id)     { presence }
  validates(:user_id)        { presence }
  validates(:class_year)     { presence }
  validates(:document_type)  { presence }
  validates(:number)         { presence }
  validates(:page)           { presence }
  validates(:download_count) { presence }
  validates(:file_name)      { presence }
  validates(:file_mime)      { presence }
  validates(:file_sha1)      { presence; uniqueness }
end
