require 'rails_helper'
require 'rake'

RSpec.describe 'Update Position Rake Task' do
  context 'for all videos in the db' do
    it 'updates any nil value for position attruibute of a video' do
      video = create(:video)
      video.position = nil
      allow(Video).to receive(:all).and_return([video])

      rake = Rake.application
      rake.init
      rake.load_rakefile
      rake['db:update_positions'].invoke

      expect(video.position).to eq(0)
    end
  end
end