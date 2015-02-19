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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "scopes" do
    describe "active_approved_users" do
      it "includes active and approved users" do
        guest = create(:guest, activate: true, approve: true)
        expect(User.active_approved_users.to_a).to eq([guest])
      end

      it "excludes active but not approved users" do
        create(:guest, activate: true, approve: false)
        expect(User.active_approved_users.to_a).to eq([])
      end

      it "excludes non-active but approved users" do
        create(:guest, activate: false, approve: true)
        expect(User.active_approved_users.to_a).to eq([])
      end

      it "excludes non-active and not approved users" do
        create(:guest, activate: false, approve: false)
        expect(User.active_approved_users.to_a).to eq([])
      end
    end

    describe "waiting_approval" do
      it "excludes active and approved users" do
        create(:guest, activate: true, approve: true)
        expect(User.waiting_approval.to_a).to eq([])
      end

      it "includes active but not approved users" do
        guest = create(:guest, activate: true, approve: false)
        expect(User.waiting_approval.to_a).to eq([guest])
      end

      it "excludes non-active but approved users" do
        create(:guest, activate: false, approve: true)
        expect(User.waiting_approval.to_a).to eq([])
      end

      it "excludes non-active and not approved users" do
        create(:guest, activate: false, approve: false)
        expect(User.waiting_approval.to_a).to eq([])
      end
    end

    describe "admins" do
      it "includes admins" do
        admin = create(:admin)
        expect(User.admins.to_a).to eq([admin])
      end

      it "excludes guests" do
        create(:guest)
        expect(User.admins.to_a).to eq([])
      end
    end
  end

  describe "class methods" do
    describe "send_approval_request_to_admin!" do
      it "sends mails" do
        admin = create(:admin)
        guest = create(:guest, approve: false)
        expect(AdminMailer).to receive(:approval_request)
                               .and_return(double("AdminMailer", deliver_now: true))
                               .with([admin], [guest])
        User.send_approval_request_to_admin!
      end
    end
  end

  describe "instance methods" do
    before(:all) do
      @user = create(:admin, activate: false)
    end

    after(:all) do
      @user.destroy!
    end

    describe "activation_url" do
      it "includes activation token" do
        expect(@user.activation_url).to     include(@user.activation_token)
      end
    end

    describe "send_activation_needed_email!" do
      it "sends a mail" do
        expect(UserMailer).to receive(:email_confirmation_on_create)
                              .and_return(double("UserMailer", deliver_now: true))
                              .with(an_instance_of(User))
        @user.send_activation_needed_email!
      end
    end

    describe "send_reset_password_instructions!" do
      it "send a mail" do
        expect(UserMailer).to receive(:reset_password_instructions)
                              .and_return(double("UserMailer", deliver_now: true))
                              .with(an_instance_of(User))
        @user.send_reset_password_instructions!
      end
    end
  end

  context "registration" do
    it "automatically send welcome email" do
      user = build(:guest, activate: false)
      expect(user).to receive(:send_activation_needed_email!).once
      user.save
    end
  end
end
