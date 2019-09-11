class IssuesController < ApplicationController
  before_action :set_project, only: [:index, :new, :show, :create, :update]
  before_action :set_issue, only: [:update, :show, :issue_map]

  def index
    @high_priority_issues = policy_scope(Issue).order(deadline: :desc).select { |issue| (issue.project == @project) && (issue.overdue? || issue.imminent?) }
    @low_priority_issues = policy_scope(Issue).order(created_at: :desc).select { |issue| (issue.project == @project) && (issue.deadline.nil? || !issue.imminent?) }
    @high_priority_pending = @high_priority_issues.select { |issue| (issue.resolved == true) && (issue.accepted == false) }
    @low_priority_pending =  @low_priority_issues.select { |issue| (issue.resolved == true) && (issue.accepted == false) }
    @completed = policy_scope(Issue).order(created_at: :desc).select { |issue| issue.accepted == true }
    if params[:query].present?
      @high_priority_issues = Issue.search_issues(params[:query]).order(deadline: :desc).select { |issue| (issue.project == @project) && (issue.overdue? || issue.imminent?) }
      @low_priority_issues = Issue.search_issues(params[:query]).order(created_at: :desc).select { |issue| (issue.project == @project) && (issue.deadline.nil? || !issue.imminent?) }
      @high_priority_pending = Issue.search_issues(params[:query]).order(deadline: :desc).select { |issue| (issue.resolved == true) && (issue.accepted == false) }
      @low_priority_pending = Issue.search_issues(params[:query]).order(created_at: :desc).select { |issue| (issue.resolved == true) && (issue.accepted == false) }
      @completed = Issue.search_issues(params[:query]).order(created_at: :desc).select { |issue| issue.accepted == true }
    end
  end

  def new
    @user = User.all
    @issue = Issue.new
    set_subcategories
  end

  def create
    @issue = Issue.new(issue_params)
    authorize @issue
    @issue.project = @project
    if params[:issue][:map_id] != ""
      @map = Map.find(params[:issue][:map_id])
      if params[:subcategories].present? && @issue.save
        params[:subcategories].each do |subcategory|
          new_categorization = Categorization.new(issue: @issue, sub_category_id: subcategory)
          new_categorization.save
        end
        redirect_to issue_map_pin_path(@issue, @map)
      else
        set_subcategories
        render 'new'
      end
    else
      render 'new'
    end
  end

  def update
    authorize @issue
    if params[:issue][:x_coordinate].present?
      @issue.x_coordinate = params[:issue][:x_coordinate]
      @issue.y_coordinate = params[:issue][:y_coordinate]
    elsif params[:issue][:resolved].present?
      @issue.resolved = params[:issue][:resolved]
    elsif params[:issue][:accepted].present?
      @issue.accepted = params[:issue][:accepted]
    end
    @issue.deadline = params[:issue][:deadline] if params[:issue][:deadline]
    if @issue.save
      redirect_to project_issue_path(@project, @issue)
    else
      render issue_map_pin_path(@project, @issue)
    end
  end

  # def update
  #   my_params = params[:issue] => {deadline: "28-09-2019", description: "bla bla" }
  #   @issue.update(my_params)
  #   if @issue.save...

  # end

  def show
    @solvers = User.where(solver: true)
    @issue_solvers = IssueSolver.where(issue: @issue)
    @issue_solver = IssueSolver.new
    @solvers = @solvers.search_solvers(params[:query]) if params[:query].present?
  end

  def issue_map
  end

  private

  def issue_params
    params.require(:issue).permit(:project_id, :map_id, :title, :deadline)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def set_subcategories
    @subcategories = SubCategory.all.map do |sub|
      { category_id: sub.category_id, id: sub.id, name: sub.name }
    end
  end
end
