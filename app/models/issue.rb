class Issue < ApplicationRecord
  belongs_to :map
  belongs_to :project
  has_many :issue_solvers, dependent: :destroy
  has_many :project_solvers, through: :issue_solvers
  has_many :messages, dependent: :destroy
  has_one :user, through: :project
  has_many :categorizations, dependent: :destroy
  has_many :sub_categories, through: :categorizations

  validates :title, presence: true
end
