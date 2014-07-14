# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      not null
#  crypted_password                :string(255)      not null
#  salt                            :string(255)      not null
#  created_at                      :datetime
#  updated_at                      :datetime
#  activation_state                :string(255)
#  activation_token                :string(255)
#  activation_token_expires_at     :datetime
#  approval_state                  :string(255)
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string(255)
#  first_name                      :string(255)      default(""), not null
#  given_name                      :string(255)      default(""), not null
#  handle_name                     :string(255)      default(""), not null
#  birthday                        :date             not null
#  email_mobile                    :string(255)
#  admin                           :boolean          default(FALSE), not null
#  graduation_year_id              :integer          default(1), not null
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :graduation_year

  validates(:email)       { presence; uniqueness; format(with: /\A[0-9a-zA-Z_\-]+@(ec|med)\.hokudai\.ac\.jp\Z/) }
  validates(:first_name)  { presence }
  validates(:given_name)  { presence }
  validates(:handle_name) { presence; uniqueness }
  validates(:birthday)    { presence }
end
