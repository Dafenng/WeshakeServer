class ShopSerializer < ActiveModel::Serializer
  attributes :id, :extern_id, :name, :addr, :tel, :region, :location, :access, :budget, :shop_type, :cuisine_type, :station, :adjusted_addr, :latitude, :longitude, :rating

  has_many :shop_photos
end
