class ShopSerializer < ActiveModel::Serializer
  attributes :id, :extern_id, :name, :addr, :latitude, :longitude, :tel, :access, :genre_info, :open_time, :holiday, :lunch_budget, :lunch_budget_average, :dinner_budget, :dinner_budget_average, :rating, :region, :area, :district, :shop_type, :genre, :cuisine

  #def attributes
  #  shop = super
  #  shop[:photo_url] = root_url.sub(/\/$/, '') + shop_[:photo_url]
  #  shop
  #end
  has_many :shop_photos
end
