class Video < ApplicationRecord

  validates_presence_of :title,
                        :description,
                        :position

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.update_positions
    all.map do |video|
      if video.position == nil
        video.update_column(:position, 0)
      end
    end
  end
end
