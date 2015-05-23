class NewsSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :text,
             :created_at,
             :updated_at,
             :errors
end
