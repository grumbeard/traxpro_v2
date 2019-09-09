class Issue < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :deadline, :datetime
    add_column :issues, :date_resolved, :datetime
    add_column :issues, :date_accepted, :datetime
  end
end
