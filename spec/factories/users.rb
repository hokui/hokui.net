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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, class: User do
    transient do
      activate true
      approve  true
    end

    id            1
    email         "admin@ec.hokudai.ac.jp"
    password      "admin"
    family_name   "admin"
    given_name    "admin"
    handle_name   "admin"
    birthday      "1990-01-01"
    email_mobile  "admin@example.com"
    class_year_id 1
    admin         true

    after(:create) do |user, evaluator|
      user.activate! if evaluator.activate
      user.approve!  if evaluator.approve
    end
  end

  factory :guest, class: User do
    transient do
      activate true
      approve  true
    end

    id            2
    email         "guest@ec.hokudai.ac.jp"
    password      "guest"
    family_name   "guest"
    given_name    "guest"
    handle_name   "guest"
    birthday      "1990-01-01"
    email_mobile  "guest@example.com"
    class_year_id 1
    admin         false

    after(:create) do |user, evaluator|
      user.activate! if evaluator.activate
      user.approve!  if evaluator.approve
    end
  end
end
