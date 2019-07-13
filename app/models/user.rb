class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def return_token(auth_info)
    auth_info['credentials']['token']
  end

  def return_handle(auth_info)
    auth_info['extra']['raw_info']['login']
  end

  def associated?(user_handle)
    if User.find_by(handle: user_handle)
      true
    else
      false
    end
  end

  def associated_tutorial(tutorial_id)
    Tutorial.where(id: tutorial_id)[0]
  end

  def sorted_videos
    User.where(id: id).joins(videos: :tutorial)
        .select('videos.*, tutorials.id')
        .order('tutorials.id, videos.position')
  end

  def friends?(user_handle)
    if self.friends == []
      false
    elsif self.already_friends(user_handle) == true
      true
    elsif self.already_friends(user_handle) == false
      false
    end
  end

  def already_friends(user_handle)
    self.friends.any? do |friend|
      friend.handle == user_handle
    end
  end

end
