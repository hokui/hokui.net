class SubjectPolicy < Struct.new(:user, :subject)
  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
