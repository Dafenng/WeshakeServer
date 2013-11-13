class ShopPhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo_type, :size_type, :photo_url, :shop_id, :description

  def attributes
    shop_photo = super
    shop_photo[:photo_url] = root_url.sub(/\/$/, '') + shop_photo[:photo_url]
    shop_photo
  end
end
