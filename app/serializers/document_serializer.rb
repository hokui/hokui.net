class DocumentSerializer < ActiveModel::Serializer
  attributes :id,
             :subject_id,
             :user_id,
             :class_year,
             :document_type,
             :number,
             :page,
             :with_answer,
             :note,
             :download_count,
             :file_name,
             :file_mime,
             :created_at,
             :updated_at,
             :errors
end
