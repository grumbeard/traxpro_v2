class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :categorizations, through: :sub_categories
end
