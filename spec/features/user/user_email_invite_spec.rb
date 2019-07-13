require 'rails_helper'


describe "As a registered user on my dashboard, I click send and invite,I should be on /invite," do
  before :each do
    @user = User.create!(email: "john@gmail.com", first_name: "John", last_name: "smith", token: ENV['GITHUB_TOKEN'], password: "password")

    @user_2 = create(:user)

    json_repo_response = File.open("./fixtures/user_repos.json")
    stub_request(:get, "https://api.github.com/user/repos").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v0.15.4'
          })
          .to_return(status: 200, body: json_repo_response, headers: {})


      json_followers_response = File.open("./fixtures/user_followers.json")
      stub_request(:get, "https://api.github.com/user/followers").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=>"token #{@user.token}",
       	  'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: json_followers_response, headers: {})

    json_following_response = File.open("./fixtures/user_following.json")
      stub_request(:get, "https://api.github.com/user/following").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'User-Agent'=>'Faraday v0.15.4'
             }).
           to_return(status: 200, body: json_following_response, headers: {})
           allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      json_user_info_response = File.open("./fixtures/user_info.json")
           stub_request(:get, "https://api.github.com/users/n-flint").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Authorization'=>'token 90d5aab3bdf233a5d620e68528eeefaa85b96e97',
         'User-Agent'=>'Faraday v0.15.4'
          }).
        to_return(status: 200, body: json_user_info_response, headers: {})

    visit dashboard_path

  end
  context "I fill in 'Github handle' with a valid github handle, I click on send invite," do
    it "My path is /dashboard, see a message for Sent invite unless user has no email associated with their account" do

      click_on "Send an Invite"

      expect(current_path).to eq("/invite")
      # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
      fill_in "Github Handle", with: "n-flint"

      click_on "Send Invite"

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("Successfully sent invite!")
      # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
    end

    # Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
  end
end
