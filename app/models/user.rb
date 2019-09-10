class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :photo, PhotoUploader

  has_many :projects, dependent: :destroy
  has_many :issues, through: :projects
  has_many :maps, through: :projects
  has_many :specializations # This links user to their specialisation in sub_category
  has_many :sub_categories, through: :specializations
  has_many :messages
  has_one :project_solver

  validates :first_name, presence: true
  validates :photo, integrity: true, processing: true

  include PgSearch::Model
  pg_search_scope :search_solvers,
    against: [:first_name, :last_name],
    associated_against: {
      sub_categories: [ :name ] # singular sub_categories
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
