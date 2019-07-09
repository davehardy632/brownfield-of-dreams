require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title} 
    it { should validate_presence_of :description} 
    it { should validate_presence_of :position} 
  end

  describe 'relationships' do
    it { should have_many :user_videos}
    it { should have_many(:users).through(:user_videos)}
    it { should belong_to :tutorial}
  end

  describe 'class methods' do 
    it '.update_positions' do
      video = create(:video)
      video.position = nil
      allow(Video).to receive(:all).and_return([video])

      expect(Video.first.position).to eq(nil)

      Video.update_positions

      expect(Video.first.position).to eq(0)
    end
  end
end