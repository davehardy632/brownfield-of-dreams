require 'rails_helper'

describe 'as a visitor' do
  describe 'on the home page' do
    context 'when it click on a tutorials show page with no videos' do
      it 'is shown a message that there are no videos currently' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
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