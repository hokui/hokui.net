require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "approval_request" do
    before do
      create(:admin)
      create(:guest, approve: false)
      @admins = User.admins
      @users = User.waiting_approval
      @mail = AdminMailer.approval_request(@admins, @users)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("[北医ネット] 新しい承認申請があります")
      expect(@mail.to).to eq(@admins.map(&:email))
      expect(@mail.from).to eq(["admin@hokui.net"])
      expect(@mail.header["X-MC-PreserveRecipients"].value).to eq("false")
    end

    it "renders the body" do
      expect(@mail.body.encoded).to include(@users.first.full_name)
    end
  end
end
