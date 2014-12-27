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

  before_create :generate_token

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(10)
    end while self.class.find_by(token: self.token)
  end
end
