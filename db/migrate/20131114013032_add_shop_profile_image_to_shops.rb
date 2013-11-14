class AddShopProfileImageToShops < ActiveRecord::Migration
  def change
    add_column :shops, :default_square_image, :string
  end
end
