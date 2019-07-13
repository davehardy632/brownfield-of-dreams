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
       	  'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: json_user_info_response, headers: {})

      json_non_email_response = File.open("./fixtures/user_non_email.json")

        stub_request(:get, "https://api.github.com/users/thecraftedgem").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: json_non_email_response, headers: {})

    visit dashboard_path

  end
  context "I fill in 'Github handle' with a valid github handle, I click on send invite," do
    it "My path is /dashboard, see a message for Sent invite unless user has no email associated with their account" do

      click_on "Send an Invite"

      expect(current_path).to eq("/invite")

      fill_in "Github Handle", with: "n-flint"

      click_on "Send Invite"

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("Successfully sent invite!")
    end

    it "If user has no associated email account throw an error flash message" do

      click_on "Send an Invite"

      expect(current_path).to eq("/invite")

      fill_in "Github Handle", with: "thecraftedgem"

      click_on "Send Invite"

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
