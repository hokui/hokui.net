class GraduationYearPolicy < Struct.new(:user, :graduation_year)
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
