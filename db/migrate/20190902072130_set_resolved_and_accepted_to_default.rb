class SetResolvedAndAcceptedToDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :issues, :resolved, false
    change_column_default :issues, :accepted, false
  end
end
