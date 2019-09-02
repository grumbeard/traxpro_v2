class AddPhotoToMaps < ActiveRecord::Migration[5.2]
  def change
    add_column :maps, :photo, :string
  end
end
