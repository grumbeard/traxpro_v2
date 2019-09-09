class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :categorizations, dependent: :destroy
  has_many :specializations, dependent: :destroy
  has_many :users, through: :specializations
  validates :name, presence: true
end
