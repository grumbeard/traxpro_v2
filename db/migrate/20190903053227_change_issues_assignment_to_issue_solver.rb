class ChangeIssuesAssignmentToIssueSolver < ActiveRecord::Migration[5.2]
  def change
    rename_table :issue_assignments, :issue_solvers
  end
end
