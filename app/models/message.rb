class Message < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  # add cloudinary
  mount_uploader :photo, PhotoUploader
end
