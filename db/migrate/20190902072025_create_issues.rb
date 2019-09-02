class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.references :map, foreign_key: true
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.boolean :resolved
      t.boolean :accepted
      t.string :description
      t.string :title
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
