class PostSerializer < ActiveModel::Serializer
  attributes :id, :message, :photo_url, :user_id, :created_at

  def attributes
    post = super
    post[:photo_url] = root_url.sub(/\/$/, '') + post[:photo_url]
    post[:created_at] = post[:created_at].localtime
    post
  end

end
