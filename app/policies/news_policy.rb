class NewsPolicy < Struct.new(:user, :news)
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
