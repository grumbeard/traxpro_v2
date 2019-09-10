class Issue < ApplicationRecord
  belongs_to :map
  belongs_to :project
  has_many :issue_solvers, dependent: :destroy
  has_many :project_solvers, through: :issue_solvers
  has_many :messages, dependent: :destroy
  has_one :user, through: :project
  has_many :categorizations, dependent: :destroy
  has_many :sub_categories, through: :categorizations
  has_many :categories, through: :sub_categories

  validates :title, presence: true, length: { maximum: 140 }
  validates :map, presence: true
  validates :categories, presence: true
  validates :subcategories, presence: true
  validates :x_coordinate, presence: true, on: :update
  validates :y_coordinate, presence: true, on: :update

  include PgSearch::Model
  pg_search_scope :search_issues,
    against: [:title],
    associated_against: {
      map: [ :title ] # singular sub_categories
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
