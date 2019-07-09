require 'rails_helper'

describe 'as a any user' do
  describe 'on the home page' do
    context 'when it click on a tutorials show page with no videos' do
      it 'is shown a message that there are no videos currently' do
        tutorial1 = create(:tutorial)
        tutorial2 = create(:tutorial)
        video1 = create(:video, tutorial_id: tutorial2.id)

        visit root_path

        click_link tutorial1.title

        expect(page).to have_content('This tutorial has no videos at this time.')
      end
    end
  end
end