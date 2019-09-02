class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects, dependent: :destroy
  has_many :issues, through: :projects
  has_many :maps, through: :projects
  has_one :project_solver

  validates :first_name, presence: true
end
