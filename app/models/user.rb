class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects, dependent: :destroy
  has_many :issues, through: :projects
  has_many :maps, through: :projects
  has_many :specializations # This links user to their specialisation in sub_category
  has_many :sub_categories, through: :specializations
  has_many :messages
  has_one :project_solver

  validates :first_name, presence: true
end
