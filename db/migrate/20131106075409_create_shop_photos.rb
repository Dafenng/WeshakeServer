class CreateShopPhotos < ActiveRecord::Migration
  def change
    create_table :shop_photos do |t|
      t.string :photo_type
      t.string :photo_url
      t.string :size_type
      t.integer :shop_id

      t.timestamps
    end
  end
end
