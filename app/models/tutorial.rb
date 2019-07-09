class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos


  def self.non_classroom
    self.where(classroom: false)
  end

  def has_videos?
    self.videos != []
  end
end
