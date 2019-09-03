class ProjectSolversController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @project_solver = ProjectSolver.new(project_solver_params)
    authorize @project_solver
    @project_solver.project = @project
    if @project_solver.save
      redirect_to project_path(@project)
    else
      redirect_to solvers_project_path(@project)
    end
  end

  private

  def project_solver_params
    params.require(:project_solver).permit(:user_id)
  end
end
