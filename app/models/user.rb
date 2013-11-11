class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy

  has_many :favors
  has_many :shops, :through => :favors

  before_create :generate_auth_token

  private

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end
end
