class Map < ApplicationRecord
  belongs_to :project
  has_many :issues, dependent: :destroy

  validates :title, presence: true
end
