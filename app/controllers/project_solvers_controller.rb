class ProjectSolversController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @project_solver = ProjectSolver.new(project_solver_params)
    @project_solver.project = @project
    @project_solver.save
  end

private

  def project_solver_params
    params.require(:project_solver).permit(:user_id)
  end
end
