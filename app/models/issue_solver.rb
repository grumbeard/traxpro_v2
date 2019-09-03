class IssueSolver < ApplicationRecord
  belongs_to :issue
  belongs_to :project_solver
end
