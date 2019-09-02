class Project < ApplicationRecord
  belongs_to :user
  has_many :maps, dependent: :destroy
  has_many :issues, through: :maps
  has_many :project_solvers, dependent: :destroy

  validates :name, presence: true
end
