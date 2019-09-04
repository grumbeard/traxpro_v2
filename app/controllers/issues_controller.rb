class IssuesController < ApplicationController
  before_action :set_project, only: [:index, :new, :create]

  def index
    # @issues = policy_scope(Issue).order(created_at: :desc)
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
    # authorize @issue
    @categories = Category.all
    @subcategories = SubCategory.all.map do |sub|
     { category_id: sub.category_id, id: sub.id, name: sub.name }
    end
  end

  def create
    @issue = Issue.new(issue_params)
    # authorize @issue
    @issue.project = @project
    if @issue.save
      redirect_to categories_path(@issue)
    else
      render 'new'
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:project_id, :map_id, :title)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
