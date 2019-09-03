class ProjectsController < ApplicationController
  # before_action :set_projects, only: [:index]

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

  private

  # def set_projects
  #   @projects = Project.all
  #   authorize @projects
  # end

  def project_params
    params.require(:project).permit(:name, :description, :photo)
  end
end
