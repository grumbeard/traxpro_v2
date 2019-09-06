class CategorizationsController < ApplicationController
  def new
    @subcategories = SubCategory.all.map do |sub|
      { category_id: sub.category_id, id: sub.id, name: sub.name }
    end
    set_issue
    @categorization = Categorization.new
    authorize @categorization
  end

  def create
  end

  private

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end
end
