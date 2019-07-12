require 'rails_helper'

describe 'vister can create an account', :js do
  before :each do
    WebMock.disable!
    @email = 'davehardy632@gmail.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'
  end
  it ' visits can create an account' do
    visit '/'

    click_on 'Register'

    expect(current_path).to eq("/register")

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(@email)
    expect(page).to have_content(@first_name)
    expect(page).to have_content(@last_name)
    expect(page).to_not have_content('Sign In')
    expect(page).to have_content("Logged in as Jim Bob")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end

  it 'can not create an account with an invalid username' do
    user = User.create!(email: 'email@email.com', first_name: 'firsty', last_name: 'lasty', password: 'password')
    visit '/'

    click_on 'Register'
    expect(current_path).to eq("/register")

    fill_in 'user[email]', with: user.email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on'Create Account'

    expect(page).to have_content('Username already exists')
  end
end
