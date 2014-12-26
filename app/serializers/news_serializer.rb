class NewsSerializer < ActiveModel::Serializer
  attributes :text,
             :created_at,
             :updated_at,
             :errors
end
