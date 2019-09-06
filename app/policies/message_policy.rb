class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user == record.issue.project.user || record.issue.project.project_solvers.pluck(:user_id).include?(user.id)
  end

  def create?
    user == record.issue.project.user || record.issue.project.project_solvers.pluck(:user_id).include?(user.id)
  end
end
