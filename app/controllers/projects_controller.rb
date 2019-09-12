class ProjectsController < ApplicationController
  before_action :set_project, only: [:solvers, :show, :chart]

  def index
    @projects = policy_scope(Project).order(created_at: :desc)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    authorize @project
    if @project.save
      redirect_to new_project_map_path(@project)
    else
      render 'new'
    end
  end

  def show
  end

  def solvers
    @solvers = User.where(solver: true)
    @project_solver = ProjectSolver.new
  end

  def chart
    @issues = @project.issues
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :description, :photo)
  end
end
