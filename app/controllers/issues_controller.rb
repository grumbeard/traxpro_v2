class IssuesController < ApplicationController
  before_action :set_project, only: [:index, :new, :create]

  def index
    @issues = policy_scope(Issue).order(created_at: :desc)
  end

  def new
    @issue = Issue.new
    @subcategories = SubCategory.all.map do |sub|
      { category_id: sub.category_id, id: sub.id, name: sub.name }
    end

    authorize @issue
  end

  def create
    @issue = Issue.new(issue_params)
    authorize @issue
    @issue.project = @project
    if @issue.save
      params[:subcategories].each do |subcategory|
        byebug
        new_categorization = Categorization.new(issue: @issue, sub_category_id: subcategory)
        new_categorization.save
      end
      redirect_to map_path(@issue.map)
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
