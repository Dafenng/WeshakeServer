class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url, :auth_token, :user_type, :type_id

  def attributes
    user = super
    user[:avatar_url] = root_url.sub(/\/$/, '') + user[:avatar_url]
    user
  end
end