require 'rails_helper'
require 'webmock/rspec'

describe "A user can add a follower/following as a friend" do
  before :each do
      @user = User.create!(email: "bill@gmail.com", first_name: "Bill", last_name: "smith", password: "password", token: ENV['GITHUB_TOKEN'], handle: "bills_handle")

      @user_2 = User.create!(email: "josh@gmail.com", first_name: "Josh", last_name: "Jones", password: "password", token: "9329ffdf2949239294d93943d3e9343943er3944", handle: "n-flint")

      @user_3 = User.create!(email: "mike@gmail.com", first_name: "Mike", last_name: "Michaelson", password: "password")

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

      visit dashboard_path
  end
  context "if they are a user in the application" do
    it "There is a link next to their name to add friend" do

      expect(current_path).to eq(dashboard_path)

      within(first(".following_user")) do
        expect(page).to have_content(@user_2.handle)
        expect(page).to have_content("Add as Friend")
      end
      expect(current_path).to eq(dashboard_path)
    end
  end
end
# within("#review-#{@review_10.id}") do
#         expect(page).to have_link(@book_1.title)
#         expect(page).to have_xpath('//img[@src="https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png"]')
#         expect(page).to have_content(@review_10.title)
#         expect(page).to have_content(@review_10.description)
#         expect(page).to have_content(@review_10.rating)
#         expect(page).to have_content(@review_10.created_at)
#       end
