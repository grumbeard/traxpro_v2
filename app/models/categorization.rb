class Categorization < ApplicationRecord
  # Understand as an instance of issue (Cocr8) and sub_category issue (Aircon leak)
  belongs_to :issue
  belongs_to :sub_category

  validates :issue, presence: true
  validates :sub_category, presence: true
end
