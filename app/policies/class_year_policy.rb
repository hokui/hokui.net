class ClassYearPolicy < Struct.new(:user, :class_year)
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
