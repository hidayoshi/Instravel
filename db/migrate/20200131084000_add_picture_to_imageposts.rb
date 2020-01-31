class AddPictureToImageposts < ActiveRecord::Migration[5.1]
  def change
    add_column :imageposts, :picture, :string
  end
end
