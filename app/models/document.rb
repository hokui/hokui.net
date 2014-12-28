# == Schema Information
#
# Table name: documents
#
#  id             :integer          not null, primary key
#  subject_id     :integer          not null
#  user_id        :integer          not null
#  class_year     :integer          not null
#  document_type  :integer          not null
#  number         :integer          default("1"), not null
#  page           :integer          default("1"), not null
#  with_answer    :boolean
#  note           :string
#  download_count :integer          default("0"), not null
#  file_name      :string           not null
#  file_mime      :string           not null
#  file_sha1      :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Document < ActiveRecord::Base
  # NOTE Attribute `class_year` is not a reference to an instance of ClassYear,
  # but the actual number of class year to which the document was distributed.

  belongs_to :subject
  belongs_to :user
  has_many :download_tokens

  validates(:subject_id)     { presence }
  validates(:user_id)        { presence }
  validates(:class_year)     { presence }
  validates(:document_type)  { presence }
  validates(:number)         { presence }
  validates(:page)           { presence }
  validates(:download_count) { presence }
  validates(:file_name)      { presence }
  validates(:file_mime)      { presence }
  validates(:file_sha1)      { presence; uniqueness }

  attr_reader :download_token

  def initialize(document_params)
    super
    self.page = (Document.where(
      subject_id: subject_id,
      class_year: class_year,
      document_type: document_type,
      number: number
    ).pluck(:page).max || 0)+ 1
    self.download_count = 0
    self
  end

  def save
    Document.transaction do
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
    self.file_mime = file_params.content_type
    self.file_sha1 = Digest::SHA1.hexdigest(@tempfile.read)
    self
  end

  def generate_download_token!
    @download_token = self.download_tokens.create!.token
    self
  end

  def file_fullpath
    "#{Figaro.env.uploaded_files_dir}/#{sprintf("%06d", id)}-#{file_name}"
  end
end
