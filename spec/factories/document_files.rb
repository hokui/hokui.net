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

FactoryGirl.define do
  factory :document_file do
    document_id       1
    user_id           1
    file_name         "dummy.pdf"
    file_content_type "application/pdf"
    file_md5          "c348a159e06d03e9905ed043ab249dda"
    comments          "hoge"
    download_count    0

    after(:create) do |df|
      FileUtils.cp(
        File.join(Rails.root, "misc", "uploaded", "000001-dummy.pdf"),
        File.join("/tmp", "#{sprintf("%06d", df.id)}-#{df.file_name}")
      )
    end
  end
end
