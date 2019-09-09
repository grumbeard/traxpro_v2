class Map < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :project
  has_many :issues, dependent: :destroy

  validates :title, presence: true
  validates :photo, presence: true
end
