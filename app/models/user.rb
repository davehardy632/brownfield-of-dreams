class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendsips
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password


  def return_token(auth_info)
    auth_info["credentials"]["token"]
  end

  def return_handle(auth_info)
    auth_info["extra"]["raw_info"]["login"]
  end

  def associated?(user_handle)
    if User.find_by(handle: user_handle)
      true
    else
      false
    end
  end
end
