class DocumentPolicy < Struct.new(:user, :document)
  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
