# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string           not null
#  salt                            :string           not null
#  created_at                      :datetime
#  updated_at                      :datetime
#  activation_state                :string
#  activation_token                :string
#  activation_token_expires_at     :datetime
#  approval_state                  :string
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string
#  family_name                     :string           default(""), not null
#  given_name                      :string           default(""), not null
#  handle_name                     :string           default(""), not null
#  birthday                        :date             default(""), not null
#  email_mobile                    :string
#  admin                           :boolean          default("f"), not null
#  class_year_id                   :integer          default("1"), not null
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :class_year
  has_many :access_tokens, dependent: :destroy
  has_many :document_files

  validates(:email)            { presence; uniqueness; format(with: /\A[0-9a-zA-Z_\-]+@(ec|med)\.hokudai\.ac\.jp\Z/) }
  validates(:family_name)      { presence }
  validates(:given_name)       { presence }
  validates(:handle_name)      { presence; uniqueness }
  validates(:birthday)         { presence }
  validates(:crypted_password) { presence }
  validates(:class_year_id)    { presence }

  after_create :send_activation_needed_email!
  after_create :register_ml_member!

  scope :waiting_approval,      -> { where(activation_state: "active", approval_state: "waiting") }
  scope :active_approved_users, -> { where(activation_state: "active", approval_state: "approved") }
  scope :admins,                -> { active_approved_users.where(admin: true) }

  def full_name
    "#{family_name} #{given_name}"
  end

  def active?
    activation_state == "active"
  end

  def approved?
    approval_state == "approved"
  end

  def activation_url
    if activation_token.blank?
      raise "activation_token is not generated"
    else
      "http://#{host}/activate/?activation_token=#{activation_token}"
    end
  end

  def reset_password_url
    if reset_password_token.blank?
      raise "reset_password_token is not generated"
    else
      "http://#{host}/reset_password/?reset_password_token=#{reset_password_token}"
    end
  end

  def send_activation_needed_email!
    UserMailer.email_confirmation_on_create(self).deliver_now
  end

  def send_reset_password_instructions!
    UserMailer.reset_password_instructions(self).deliver_now
  end

  def register_ml_member!
    member = MailingList::Member.create!(
      name: self.full_name,
      email: self.email,
      email_sub: self.email_mobile
    )
    self.ml_member_id = member.id
    self.save!
  end

  class << self
    def send_approval_request_to_admin!
      AdminMailer.approval_request(admins, waiting_approval).deliver_now
    end
  end

  private

  def host
    Rails.application.routes.default_url_options[:host]
  end
end
