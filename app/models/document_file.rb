# == Schema Information
#
# Table name: document_files
#
#  id                :integer          not null, primary key
#  document_id       :integer          not null
#  user_id           :integer          not null
#  file_name         :string           not null
#  file_content_type :string           not null
#  file_md5          :string           not null
#  comments          :string
#  download_count    :integer          default("0"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class DocumentFile < ActiveRecord::Base
  belongs_to :document
  belongs_to :user

  validates(:document_id)       { presence }
  validates(:user_id)           { presence }
  validates(:file_name)         { presence }
  validates(:file_content_type) { presence }
  validates(:file_md5)          { presence; uniqueness }
  validates(:download_count)    { presence }
end
