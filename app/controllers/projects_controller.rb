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
    @stacked_column = params[:commit]

      # @it_is = "it is Daily"

      @charts_data = @project.generate_chart

    # elsif @stacked_column == "Weekly"
    #   @it_is = "it is Weekly"
    # elsif @stacked_column == "Monthly"
    #   @it_is = "it is Monthly"
  end

# calculate based on the week
# if stacked_column == "Daily"
#   assign Time.now to variable named "before_this_date"
#   create an array with the number of accepted, resolved, pending and overdue issues
#     up to "before_this_date" for the project and
#     then display the array values on a stacked bar
#   reassign "before_this_date" variable to the DAY before and
#   loop to create an array for the next column until the earliest issue is reached

      # calculate based on whatever the used passed
      # After calculation we found the result
      # result = [40, 47, 44, 38, 27];
      # @data = result
  #   end
  # end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :description, :photo)
  end
end
