# == Schema Information
#
# Table name: document_files
#
#  id                :integer          not null, primary key
#  document_id       :integer          not null
#  user_id           :integer          not null
#  file_name         :string           not null
#  file_content_type :string           not null
#  file_md5          :string           not null
#  comments          :string
#  download_count    :integer          default("0"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe DocumentFile, :type => :model do
end
