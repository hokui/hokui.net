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

RSpec.describe DownloadToken, :type => :model do
end
