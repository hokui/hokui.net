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

require 'rails_helper'

RSpec.describe Document, :type => :model do
end
