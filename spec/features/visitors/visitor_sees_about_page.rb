require 'rails_helper'

RSpec.describe 'as a visitor' do
  context 'on the root page' do
    it 'can visit the about page' do
      visit root_path

      click_link 'About'
      
      exepect(current_path).to eq(about_path)
      exepect(page).to have_content('This application is designed')
    end
  end
end