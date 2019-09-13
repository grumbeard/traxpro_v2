class Project < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :maps, dependent: :destroy
  has_many :issues, through: :maps, dependent: :destroy
  has_many :project_solvers, dependent: :destroy
  validates :name, presence: true

  @@bar_date = Time.now

  def cumulative_issues_raised
    self.issues.select { |issue| issue.date_created < @@bar_date }
  end

  def cumulative_issues_accepted
    self.issues.where(resolved: true).where(accepted: true).where('date_created < ?', @@bar_date)
  end

  def cumulative_issues_resolved
    self.issues.where(resolved: true).where(accepted: false).where('date_created < ?', @@bar_date)
  end

  def cumulative_issues_pending
    self.issues.where(resolved: false).where(accepted: false).where('date_created < ?', @@bar_date)
  end

  def cumulative_issues_overdue
    self.issues.where(resolved: false).where(accepted: false).where('date_created > ?', @@bar_date)
  end

  def generate_chart
    final = [['Issues', 'Accepted', 'Solved', 'Pending', 'Overdue', { role: 'annotation' }]]
    @issues_week = Hash.new()
    clean_array = self.issues.pluck(:date_created)
    clean_array.delete(nil)
    clean_array.uniq.map do |date|
      if @issues_week[date].nil?
        @issues_week[date.strftime('%W')] = [date]
      else
        @issues_week[date.strftime('%W')] << date
      end
    end
      @issues_week.each do |k, v|
        partial = []
        week = k
        partial << week
        partial << self.cumulative_issues_accepted.where(date_created: v ).count
        partial << self.cumulative_issues_resolved.where(date_created: v).count
        partial << self.cumulative_issues_pending.where(date_created: v).count
        partial << self.cumulative_issues_overdue.where(date_created: v).count
        partial << partial[1..-1].reduce(:+)
        final << partial
    end
    final
  end

  def generate_cumulative_chart
    final = [['Issues', 'Accepted', 'Solved', 'Pending', 'Overdue', { role: 'annotation' } ]]
    @issues_week = Hash.new()
    self.issues.pluck(:date_created).uniq.map do |date|
      if @issues_week[date.strftime('%W')].nil?
        @issues_week[date.strftime('%W')] = [date]
      else
        @issues_week[date.strftime('%W')] << date
      end
    end
      @issues_week.each do |k, v|
        partial = []
        week = k
        partial << week
        partial << self.cumulative_issues_accepted.where(date_created: v ).count
        partial << self.cumulative_issues_resolved.where(date_created: v).count
        partial << self.cumulative_issues_pending.where(date_created: v).count
        partial << self.cumulative_issues_overdue.where(date_created: v).count
        partial << partial[1..-1].reduce(:+)
        final << partial
    end
    final
  end

end
