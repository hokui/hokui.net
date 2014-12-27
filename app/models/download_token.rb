# == Schema Information
#
# Table name: download_tokens
#
#  id          :integer          not null, primary key
#  document_id :integer          not null
#  token       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DownloadToken < ActiveRecord::Base
  belongs_to :document
end
