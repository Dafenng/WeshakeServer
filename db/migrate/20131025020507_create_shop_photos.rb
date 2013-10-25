class CreateShopPhotos < ActiveRecord::Migration
  def change
    create_table :shop_photos do |t|
      t.string :num_id
      t.string :photo_url
      t.integer :shop_id

      t.timestamps
    end
  end
end
