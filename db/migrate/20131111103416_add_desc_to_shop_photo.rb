class AddDescToShopPhoto < ActiveRecord::Migration
  def change
    add_column :shop_photos, :description, :string
  end
end
