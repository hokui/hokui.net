# == Schema Information
#
# Table name: access_tokens
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  token            :string(255)      not null
#  last_activity_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe AccessToken, :type => :model do
  describe "class method" do
    describe "find_token" do
      it "finds AccessToken instance which has token passed as an argument" do
        access_token = create(:access_token)
        4.times do
          create(:access_token)
        end
        expect(AccessToken.find_token(access_token.token)).to eq(access_token)
      end
    end

    describe "delete_expired" do
      it "deletes expired token" do
        old_size = AccessToken.count
        2.times do
          create(:access_token)
        end
        3.times do
          access_token = create(:access_token)
          access_token.last_activity_at = Time.now - 3.weeks
          access_token.save
        end
        AccessToken.delete_expired
        expect(AccessToken.count).to eq(old_size + 2)
      end
    end
  end
end
