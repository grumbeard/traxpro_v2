class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def solvers?
    return true
  end

  def chart?
    true
  end
end
