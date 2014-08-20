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

require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:admin) }

  describe "activation_url" do
    it "includes local part of email and activation token" do
      expect(user.activation_url).to     include(user.email_local)
      expect(user.activation_url).not_to include("hokudai.ac.jp")
      expect(user.activation_url).to     include(user.activation_token)
    end
  end

  describe "send_activation_needed_email!" do
    it "sends a mail" do
      old_size = ActionMailer::Base.deliveries.size
      user.send_activation_needed_email!
      expect(ActionMailer::Base.deliveries.size).to eq old_size + 1
    end
  end
end
