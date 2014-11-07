class SubjectSerializer < ActiveModel::Serializer
  attributes :id,
             :title_ja,
             :title_en,
             :created_at,
             :updated_at,
             :errors
end
