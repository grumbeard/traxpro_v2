class RemoveDescriptionFromIssues < ActiveRecord::Migration[5.2]
  def change
    remove_column :issues, :description
  end
end
