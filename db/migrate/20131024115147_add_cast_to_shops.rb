class AddCastToShops < ActiveRecord::Migration
  def change
    add_column :shops, :cost, :integer
  end
end
