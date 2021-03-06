class MapsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @map = Map.new
    authorize @map
  end

  def create
    @map = Map.new(map_params)
    authorize @map
    @map.project = Project.find(params[:project_id])
    if @map.save
      redirect_to solvers_project_path(@map.project)
    else
      render 'new'
    end
  end

  def show
    @map = Map.find(params[:id])
    authorize @map
    @issues = Issue.where("map_id = #{@map.id}").map do |issue|
      { map_id: issue.map_id, id: issue.id, x_coordinate: issue.x_coordinate, y_coordinate: issue.y_coordinate }
    end
  end

  def pin
    @issue = Issue.find(params[:issue_id])
    @map = Map.find(params[:map_id])
  end

  private

  def map_params
    params.require(:map).permit(:title, :photo)
  end
end
