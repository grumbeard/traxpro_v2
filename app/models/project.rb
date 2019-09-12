class Project < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :maps, dependent: :destroy
  has_many :issues, through: :maps, dependent: :destroy
  has_many :project_solvers, dependent: :destroy

  validates :name, presence: true

  def issues_created_last_month
    self.issues.select { |issue| issue.date_created.month == Time.now.month - 1 }
  end

  def issues_resolved_last_month
    self.issues.select { |issue| issue.date_resolved.month == Time.now.month - 1 }
  end

# def issues_accepted_last_month
#     self.issues.select { |issue| issue.date_accepted.month == Time.now.month - 1 }
#   end

  # def issues_created_last_month
  #   self.issues.select { |issue| issue.date_created.month == Time.now.month - 1 }
  # end

  # t.datetime "date_created"
  # t.datetime "date_resolved"
  # t.datetime "date_accepted"
end
