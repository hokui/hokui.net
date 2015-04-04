class AddPreviousUserNameAndPreviousUserClassYearToDocumentFiles < ActiveRecord::Migration
  def change
    add_column :document_files, :previous_user_name, :string
    add_column :document_files, :previous_user_class_year, :integer
  end
end
