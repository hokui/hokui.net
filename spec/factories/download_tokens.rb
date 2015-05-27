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

FactoryGirl.define do
  factory :download_token do
    token            SecureRandom.hex(10)
  end
end
