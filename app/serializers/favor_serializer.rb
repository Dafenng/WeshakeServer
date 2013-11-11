class FavorSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :shop_id
end
