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

FactoryGirl.define do
  factory :document do
    subject_id 1
    user_id 1
    class_year 93
    document_type 1
    number 1
    page 1
    with_answer false
    note "dummy file"
    download_count 1
    file_name "dummy.pdf"
    file_mime "application/pdf"
    file_sha1 "971724c8f2664d75a600b372c15353bde841f8e8"
  end
end
