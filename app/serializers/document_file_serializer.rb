class DocumentFileSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :file_name,
             :file_content_type,
             :download_count,
             :created_at,
             :updated_at,
<<<<<<< Updated upstream
             :errors,
             :user

  belongs_to :document

  def user
    if object.user_id == 1
      { name: object.previous_user_name, class_year: object.previous_user_class_year }
    else
      { name: object.user.handle_name, class_year: object.user.class_year.year }
    end
  end
=======
             :errors
>>>>>>> Stashed changes
end
