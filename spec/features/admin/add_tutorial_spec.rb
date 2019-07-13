require 'rails_helper'

RSpec.describe 'as an admin' do
  context 'on the admin dashboard' do
    it 'can add a new tutorial' do
      admin = User.create(email: 'email@email.com', first_name: 'bigge', last_name: 'smalls', password: 'password', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_link 'New Tutorial'

      expect(current_path).to eq(new_admin_tutorial_path)

      fill_in "tutorial[title]", with: "Test Video 1"
      fill_in "tutorial[description]", with: "Description of Test Video 1"
      fill_in "tutorial[thumbnail]", with: "url of image"

      click_button 'Save'

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content('Test Video 1')
      expect(page).to have_content('Successfully created video.')
    end
  end
end