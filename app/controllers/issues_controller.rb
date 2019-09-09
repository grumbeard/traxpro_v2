class IssuesController < ApplicationController
  before_action :set_project, only: [:index, :new, :create, :update]
  before_action :set_issue, only: [:update, :show, :issue_map]

  def index
    @issues = policy_scope(Issue).order(created_at: :desc).select { |issue| issue.project == @project }
    @issues = Issue.search_issues(params[:query]) if params[:query].present?
  end

  def new
    @user = User.all
    @issue = Issue.new
    @subcategories = SubCategory.all.map do |sub|
      { category_id: sub.category_id, id: sub.id, name: sub.name }
    end
  end

  def create
    @issue = Issue.new(issue_params)
    authorize @issue
    @issue.project = @project
    @map = Map.find(params[:issue][:map_id])
    if @issue.save
      params[:subcategories].each do |subcategory|
        new_categorization = Categorization.new(issue: @issue, sub_category_id: subcategory)
        new_categorization.save
      end
      redirect_to issue_map_pin_path(@issue, @map)
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
    if @issue.save
      redirect_to issue_messages_path(@issue)
    else
      render issue_map_pin_path(@project, @issue)
    end
  end

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
    params.require(:issue).permit(:project_id, :map_id, :title)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
