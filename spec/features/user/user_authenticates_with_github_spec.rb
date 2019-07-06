require 'rails_helper'
require 'webmock/rspec'

describe "As a registered user, when I visit my dashboard, /dashboard" do
  before :each do

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
       	  # 'Authorization'=>"token #{@user.token}",
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
  end
  context "There is a link to connect to github" do
    it "Shows a link if user has not signed in with github(has no token)" do
      OmniAuth.config.test_mode = true
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_link("Connect to Github")
    end

    it "Shows all github repository info, (five repos, all followers and following) if authenticated with github" do
      OmniAuth.config.test_mode = true
      user = create(:user)
      auth_info = OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                :provider => 'github',
                                :uid => '123545',
                                :credentials => {
                                  :token => ENV["GITHUB_TOKEN"]
                                }
                                })

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


      visit dashboard_path

      click_link "Connect to Github"

      expect(current_path).to eq(dashboard_path)
      expect(user.token).to eq(ENV["GITHUB_TOKEN"])

      expect(page).to_not have_link("Connect to Github")

      within(".github") do
        within(".github-followers") do
          expect(page).to have_css(".follower", count: 3)
          expect(page).to have_link("Loomus")
          expect(page).to have_link("ryanmillergm")
          expect(page).to have_link("earl-stephens")
        end
      end
    end
  end
end
