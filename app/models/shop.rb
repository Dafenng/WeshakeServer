class Shop < ActiveRecord::Base
  has_many :shop_photos, dependent: :destroy

  geocoded_by :addr                  # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
end
