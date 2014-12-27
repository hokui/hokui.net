# == Schema Information
#
# Table name: download_tokens
#
#  id          :integer          not null, primary key
#  document_id :integer          not null
#  token       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :download_token do
    document_id 1
    token "5fe3733657976e25f72b"
  end
end
