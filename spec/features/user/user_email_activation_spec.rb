require 'rails_helper'

RSpec.describe 'as a unactivated user' do
  describe 'when registering a new account' do
    before :each do
      WebMock.disable!
    end
    it 'sees a notification to activate account by email' do
      email = 'email@google.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit '/'

      click_on 'Register'

      expect(current_path).to eq(register_path)

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{email}")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
    xit 'sees a message after successful email activation' do
      user = create(:user, email: 'email@google.com', password: 'password')
      
      visit login_path
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Status: Not Active')      
      click_link 'Visit here to activate your account.'

      # visit call back path from activation email?

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Thank you! Your account is now activated')
      expect(page).to have_content('Status: Active')
      require 'pry'; binding.pry
    end
  end
end

