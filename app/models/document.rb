class Document < ActiveRecord::Base
  # NOTE Attribute `class_year` is not a reference to an instance of ClassYear,
  # but the actual number of class year to which the document was distributed.

  belongs_to :subject
  belongs_to :user

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
end
