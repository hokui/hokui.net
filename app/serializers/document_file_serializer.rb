class DocumentFileSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :file_name,
             :file_content_type,
             :download_count,
             :download_token,
             :created_at,
             :updated_at,
             :errors,
             :user

  belongs_to :document

  def download_token
    DownloadToken.last.token
  end

  def user
    if object.user_id == 1
      { name: object.previous_user_name, class_year: object.previous_user_class_year }
    else
      { name: object.user.handle_name, class_year: object.user.class_year.year }
    end
  end
end
