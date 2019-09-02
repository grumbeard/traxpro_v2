class ProjectSolver < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :issue_assignments, dependent: :destroy
end
