require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "email_confirmation_on_create" do
    let(:user) { create(:admin) }
    let(:mail) { UserMailer.email_confirmation_on_create(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("北医ネットへようこそ！")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["admin@hokui.net"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(user.full_name)
      expect(mail.body.encoded).to include(user.activation_url)
    end
  end

end
