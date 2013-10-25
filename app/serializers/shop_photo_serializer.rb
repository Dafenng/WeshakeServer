class ShopPhotoSerializer < ActiveModel::Serializer
  attributes :id, :num_id, :photo_url, :shop_id

  def attributes
    shop_photo = super
    shop_photo[:photo_url] = root_url.sub(/\/$/, '') + shop_photo[:photo_url]
    shop_photo
  end
end
