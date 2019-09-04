class CategorizationsController < ApplicationController
  def create
    @categorization = Categorization.new
    authorize @categorization
  end
end
