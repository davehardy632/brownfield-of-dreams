require 'rails_helper'

describe GithubApiService do
  before :each do

    WebMock.disable!
    @user = User.create(email: "john@gmail.com", first_name: "John", last_name: "smith", token: ENV['GITHUB_TOKEN'])

    @service = GithubApiService.new(@user.token)
    end

    it "exists" do
      expect(@service.class).to eq(GithubApiService)
    end

  context "#repos" do
    it "returns a given number of github repositories with token" do
      repo_data = @service.repos[0]
      expect(repo_data).to be_a Hash
      expect(repo_data).to have_key :name
      expect(repo_data).to have_key :html_url
    end
  end

  context "#following" do
    it "returns a given number of github users, current user is following" do
      following = @service.following[0]

      expect(following).to be_a Hash
      expect(following).to have_key :login
      expect(following).to have_key :html_url
    end
  end

  context "#followers" do
    it "returns all github follower handles, and links to their github accounts" do
      follower_data = @service.followers[0]

      expect(follower_data).to be_a Hash
      expect(follower_data).to have_key :login
      expect(follower_data).to have_key :html_url
    end
  end
end
