class Issue < ApplicationRecord
  belongs_to :map
  belongs_to :project
  has_many :issue_assignments, dependent: :destroy
  has_many :project_solvers, through: :issue_assignments
  has_one :user, through: :project

  validates :title, presence: true
end
