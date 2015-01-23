class NewsSerializer < ActiveModel::Serializer
  attributes :title,
             :text,
             :created_at,
             :updated_at,
             :errors
end
