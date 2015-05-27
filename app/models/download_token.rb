# == Schema Information
#
# Table name: download_tokens
#
#  id               :integer          not null, primary key
#  document_file_id :integer          not null
#  token            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class DownloadToken < ActiveRecord::Base
  TERM_OF_VALIDITY = 2.days

  validates(:token)            { presence; uniqueness }

  before_validation :generate_token, on: :create

  def self.find_token(token)
    download_token = self.find_by(token: token)
    if download_token && !download_token.expired?
      download_token
    else
      nil
    end
  end

  def self.delete_expired!
    self
      .where
      .not(created_at: (Time.now - TERM_OF_VALIDITY)..Time.now)
      .delete_all
  end

  def expired?
    Time.now - TERM_OF_VALIDITY > self.created_at
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(10)
    end while self.class.find_by(token: self.token)
  end
end
