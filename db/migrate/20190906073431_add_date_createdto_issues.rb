class AddDateCreatedtoIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :date_created, :datetime
  end
end
