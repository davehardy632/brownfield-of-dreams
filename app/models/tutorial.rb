class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.non_classroom
    where(classroom: false)
  end

  def videos?
    videos != []
  end
end
