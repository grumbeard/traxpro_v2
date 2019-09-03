class Specialization < ApplicationRecord
  # Understand as Tan (User) + Wiring (sub_category_id), Tan can have multiple specializations
  belongs_to :sub_category
  belongs_to :user
end
