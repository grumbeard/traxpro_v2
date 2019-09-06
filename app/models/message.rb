class Message < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  has_one :map, through: :issue
  has_one :project, through: :issue
  # add cloudinary
  mount_uploader :photo, PhotoUploader
end
