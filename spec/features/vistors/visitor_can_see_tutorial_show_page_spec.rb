require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    context 'it can click on a tutorials title' do
      it 'is redirected to new video page if empty' do
        tutorial1 = create(:tutorial)
        tutorial2 = create(:tutorial)
        video1 = create(:video, tutorial_id: tutorial2.id)

        visit root_path

        click_link tutorial1.title

        expect(current_path).to eq(new_video_path)
      end
    end
  end
end