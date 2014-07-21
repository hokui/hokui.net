class UserPolicy < Struct.new(:user, :user_record)
  def index?
    user.admin?
  end

  def show?
    user.admin? or user == user_record
  end
end
