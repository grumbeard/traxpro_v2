class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.references :project, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
