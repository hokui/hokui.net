class DocumentFileSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :file_name,
             :file_content_type,
             :download_count,
             :created_at,
             :updated_at,
             :errors

  belongs_to :document
end
