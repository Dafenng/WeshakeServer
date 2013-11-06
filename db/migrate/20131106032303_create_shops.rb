class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :extern_id
      t.string :addr
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :genre_info
      t.string :tel
      t.string :access
      t.string :open_time
      t.string :holiday
      t.string :lunch_budget
      t.integer :lunch_budget_average
      t.string :dinner_budget
      t.integer :dinner_budget_average
      t.float :rating
      t.string :region
      t.string :area
      t.string :district
      t.string :shop_type
      t.string :genre
      t.string :cuisine
      
      t.timestamps
    end
  end
end
