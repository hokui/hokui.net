class SemesterPolicy < Struct.new(:user, :semester)
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
