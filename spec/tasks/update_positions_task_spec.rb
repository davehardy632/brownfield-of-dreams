require 'rails_helper'
require 'rake'
# Rake.application.rake_require '././lib/tasks/update_video_nill_positions.rake'

RSpec.describe 'Update Position Rake Task' do
  context 'for all videos in the db' do
    xit 'updates any nil value for position attruibute of a video' do
      video = create(:video)
      video.position = nil
      allow(Video).to receive(:all).and_return([video])

      Rake::Task[import:update].invoke

      expect(video.position).to eq(0)
    end
  end
end