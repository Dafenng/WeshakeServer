class Post < ActiveRecord::Base
  mount_uploader :photo, PostPhotoUploader
  belongs_to :user
end
