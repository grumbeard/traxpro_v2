class CreateIssueAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_assignments do |t|
      t.references :issue, foreign_key: true
      t.references :project_solver, foreign_key: true

      t.timestamps
    end
  end
end
