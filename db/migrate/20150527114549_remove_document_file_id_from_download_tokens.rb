class RemoveDocumentFileIdFromDownloadTokens < ActiveRecord::Migration
  def change
    remove_column :download_tokens, :document_file_id, :integer
  end
end
