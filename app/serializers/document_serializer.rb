class DocumentSerializer < ActiveModel::Serializer
  attributes :id,
             :subject_id,
             :class_year,
             :code,
             :created_at,
             :updated_at,
             :errors

  has_many :document_files, serializer: DocumentFileSerializer
end
