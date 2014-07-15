class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :full_name,
             :handle_name,
             :birthday,
             :email_mobile,
             :admin,
             :graduation_year_id,
             :persisted,
             :errors

  def full_name
    "#{object.family_name} #{object.given_name}"
  end

  def persisted
    object.persisted?
  end

  def errors
    object.errors
  end
end
