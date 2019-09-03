class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :categorizations, dependent: :destroy
  has_many :specializations
  has_many :users, through: :specializations
end
