require 'rails_helper'

RSpec.describe 'as a visitor' do
  context 'on the root page' do
    it 'can visit the about page' do
      visit '/'

      click_link 'About'
      
      # this hits a pry in the about#show, but is not coverd by simplecov?
      expect(current_path).to eq(about_path)
      expect(page).to have_content('This application is designed')
    end
    it 'sees a link to the get started page on the about page' do
      visit about_path

      click_link 'Get Started'

      expect(current_path).to eq(get_started_path)
      expect(page).to have_content('Get Started')
    end
  end
end