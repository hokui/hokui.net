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
#  family_name                     :string(255)      default(""), not null
#  given_name                      :string(255)      default(""), not null
#  handle_name                     :string(255)      default(""), not null
#  birthday                        :date             not null
#  email_mobile                    :string(255)
#  admin                           :boolean          default(FALSE), not null
#  graduation_year_id              :integer          default(1), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, class: User do
    email              "admin@ec.hokudai.ac.jp"
    password           "admin"
    family_name        "admin"
    given_name         "admin"
    handle_name        "admin"
    birthday           "1990-01-01"
    email_mobile       "admin@example.com"
    graduation_year_id 1
    admin              true
  end
