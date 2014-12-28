# == Schema Information
#
# Table name: access_tokens
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  token            :string           not null
#  last_activity_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class AccessToken < ActiveRecord::Base
  TERM_OF_VALIDITY = 2.weeks

  belongs_to :user

  validates(:user_id) { presence }
  validates(:token)   { presence; uniqueness }

  before_validation :generate_token, :update_last_activity_time, on: :create

  def self.find_token(token)
    access_token = self.find_by(token: token)
    if access_token && !access_token.expired?
      access_token
    else
      nil
    end
  end

  def self.delete_expired!
    self
      .where
      .not(last_activity_at: (Time.now - TERM_OF_VALIDITY)..Time.now)
      .delete_all
  end

  def expired?
    Time.now - TERM_OF_VALIDITY > self.last_activity_at
  end

  def update_last_activity_time
    self.last_activity_at = Time.now
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(32)
    end while self.class.find_by(token: self.token)
  end
end
