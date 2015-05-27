# == Schema Information
#
# Table name: download_tokens
#
#  id               :integer          not null, primary key
#  document_file_id :integer          not null
#  token            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe DownloadToken, type: :model do
  describe "class methods" do
    describe "find_token" do
      it "finds DownloadToken instance which has token passed as an argument" do
        download_token = create(:download_token)
        4.times do
          create(:download_token)
        end
        expect(DownloadToken.find_token(download_token.token)).to eq(download_token)
      end
    end

    describe "delete_expired!" do
      it "deletes expired token" do
        old_size = DownloadToken.count
        3.times do
          download_token = create(:download_token)
          download_token.created_at = Time.now - 3.days
          download_token.save
        end
        2.times do
          create(:download_token)
        end
        DownloadToken.delete_expired!
        expect(DownloadToken.count).to eq(old_size + 2)
      end
    end
  end
end
