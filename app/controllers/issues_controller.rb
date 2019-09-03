class IssuesController < ApplicationController
  def index
    @issues = policy_scope(Issue).order(created_at: :desc)
  end

  def new
  end
end
