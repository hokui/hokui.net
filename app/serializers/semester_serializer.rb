class SemesterSerializer < ActiveModel::Serializer
  attributes :id,
             :class_year_id,
             :identifier,
             :subject_ids,
             :created_at,
             :updated_at
end
