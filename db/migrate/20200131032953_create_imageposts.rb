class CreateImageposts < ActiveRecord::Migration[5.1]
  def change
    create_table :imageposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
