class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :name, null: false
      t.string :photo_type
      t.string :accuracy

      t.timestamps
    end
  end
end
