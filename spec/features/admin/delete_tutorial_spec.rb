require 'rails_helper'

RSpec.describe 'as an admin' do
  context 'on the admin dashboard' do
    it 'can delete a tutorial, which deletes the videos in it' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      @tutorial_1 = create(:tutorial, classroom: true)
      @video1 = create(:video, tutorial_id: @tutorial_1.id)

      visit admin_dashboard_path

      save_and_open_page
      expect(Video.all.count).to eq(1)
      expect(Tutorial.all.count).to eq(1)
      within first('.admin-tutorial-card') do
        click_link 'Destroy'
      end
      
      expect(Video.all.count).to eq(0)
      expect(Tutorial.all.count).to eq(0)
      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end