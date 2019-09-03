class CreateSpecializations < ActiveRecord::Migration[5.2]
  def change
    create_table :specializations do |t|
      t.references :sub_category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
