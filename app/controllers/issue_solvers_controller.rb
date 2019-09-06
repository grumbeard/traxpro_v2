class IssueSolversController < ApplicationController
  def create
    @issue = Issue.find(params[:issue_id])
    @issue_solver = IssueSolver.new(issue_solver_params)
    # authorize @issue_solver
    @user = User.find(params[:issue_solver][:user_id])
    @issue_solver.project_solver = @user.project_solver
    @issue_solver.issue = @issue
    if @issue_solver.save
      flash[:notice] = "Solver was succesfully added!"
      redirect_to project_issue_path(@issue.project, @issue)
    else
      flash[:alert] = "You can`t perform this action"
      redirect_to project_issue_path(@issue.project, @issue)
    end
  end

  private

  def issue_solver_params
    params.require(:issue_solver).permit(:project_solver, :issue)
  end
end
