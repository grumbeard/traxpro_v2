class MapsController < ApplicationController
  def show
  end

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
      redirect_to project_solvers_path(@map.project)
    else
      render 'new'
    end
  end

  private

  def map_params
    params.require(:map).permit(:title, :photo)
  end
end
