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

class DocumentFile < ActiveRecord::Base
  belongs_to :document
  belongs_to :user
  has_many :download_tokens, dependent: :destroy

  validates(:document_id)       { presence }
  validates(:user_id)           { presence }
  validates(:file_name)         { presence }
  validates(:file_content_type) { presence }
  validates(:file_md5)          { presence; uniqueness }
  validates(:download_count)    { presence }

  def save_with_file
    DocumentFile.transaction do
      self.save!
      if @tempfile
        @tempfile.rewind
        File.binwrite(file_fullpath, @tempfile.read)
      end
    end
    true
  rescue => e
    logger.error(e.inspect)
    false
  end

  def attach_file(file_params)
    @tempfile = file_params.tempfile
    self.file_name = file_params.original_filename
    self.file_content_type = file_params.content_type
    self.file_md5 = Digest::MD5.hexdigest(@tempfile.read)
    self
  end

  def file_fullpath
    "#{Figaro.env.uploaded_files_dir}/#{sprintf("%06d", id)}-#{file_name}"
  end

  def generate_download_token!
    self.download_tokens.create!
  end
end
