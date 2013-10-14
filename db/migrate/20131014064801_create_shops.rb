class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.integer :extern_id
      t.string :name
      t.string :addr
      t.string :tel
      t.string :region
      t.string :location
      t.string :access
      t.string :budget
      t.string :shop_type
      t.string :cuisine_type
      t.string :station
      t.string :adjusted_addr
      t.float :latitude
      t.float :longitude
      t.float :rating

      t.timestamps
    end
  end
end
