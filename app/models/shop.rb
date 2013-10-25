class Shop < ActiveRecord::Base
  has_many :shop_photos, dependent: :destroy
end
