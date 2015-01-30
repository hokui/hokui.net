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
  TERM_OF_VALIDITY = 30.minutes

  belongs_to :document_file

  validates(:document_file_id) { presence }
  validates(:token)            { presence; uniqueness }

  before_validation :generate_token, on: :create

  def self.delete_expired!
    self
      .where
      .not(created_at: (Time.now - TERM_OF_VALIDITY)..Time.now)
      .delete_all
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(10)
    end while self.class.find_by(token: self.token)
  end
end
