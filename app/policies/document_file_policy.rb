class DocumentFilePolicy < Struct.new(:user, :document_file)
  def update?
    user.admin? or document_file.user == user
  end

  def destroy?
    user.admin? or document_file.user == user
  end
end
