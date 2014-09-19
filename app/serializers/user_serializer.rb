class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :full_name,
             :handle_name,
             :birthday,
             :email_mobile,
             :admin,
             :class_year_id,
             :errors

  def full_name
    object.full_name
  end

  def errors
    object.errors
  end
end
