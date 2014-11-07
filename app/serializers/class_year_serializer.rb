class ClassYearSerializer < ActiveModel::Serializer
  attributes :id,
             :year,
             :created_at,
             :updated_at,
             :errors
end
