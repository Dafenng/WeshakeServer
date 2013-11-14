class ShopSerializer < ActiveModel::Serializer
  attributes :id, :extern_id, :name, :addr, :latitude, :longitude, :tel, :access, :genre_info, :open_time, :holiday, :lunch_budget, :lunch_budget_average, :dinner_budget, :dinner_budget_average, :rating, :region, :area, :district, :shop_type, :genre, :cuisine, :default_square_image

  def attributes
    shop = super
    unless shop[:default_square_image].nil?
      shop[:default_square_image] = root_url.sub(/\/$/, '') + shop[:default_square_image]
    end
    shop
  end
end
