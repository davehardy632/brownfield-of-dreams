require 'rails_helper'


RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create!(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end

    it ".friends?" do
      user = User.create!(first_name: "Tim", last_name: "Smith", email: "timemail@gmail.com", password: "password", handle: "asdf")
      user_2 = User.create!(first_name: "Jim", last_name: "Person", email: "jimmail@gmail.com", password: "password", handle: "whatevs")
      user_3 = User.create!(first_name: "Dan", last_name: "Humanoid", email: "danmail@gmail.com", password: "password", handle: "eyyyyy")

      user.friends << user_2

      expect(user.not_friends?(user_3.handle)).to eq(true)
      expect(user.not_friends?(user_2.handle)).to eq(false)
    end
  end

  describe 'instance methods' do
    before :each do
      @user = create(:user)

      @tutorial_1 = create(:tutorial)
      @tutorial_2 = create(:tutorial)

      @video_1 = create(:video, tutorial: @tutorial_2, position: 1)
      @video_2 = create(:video, tutorial: @tutorial_1, position: 1)
      @video_3 = create(:video, tutorial: @tutorial_1, position: 0)
      @video_4 = create(:video, tutorial: @tutorial_2, position: 0)

      @user_video_1 = UserVideo.create!(user: @user, video: @video_1)
      @user_video_2 = UserVideo.create!(user: @user, video: @video_2)
      @user_video_3 = UserVideo.create!(user: @user, video: @video_3)
      @user_video_4 = UserVideo.create!(user: @user, video: @video_4)
    end

    it '.sorted_videos' do
      expect(@user.sorted_videos[0].title).to eq(@video_3.title)
      expect(@user.sorted_videos[0].thumbnail).to eq(@video_3.thumbnail)
      expect(@user.sorted_videos[1].title).to eq(@video_2.title)
      expect(@user.sorted_videos[1].thumbnail).to eq(@video_2.thumbnail)
      expect(@user.sorted_videos[2].title).to eq(@video_4.title)
      expect(@user.sorted_videos[2].thumbnail).to eq(@video_4.thumbnail)
      expect(@user.sorted_videos[3].title).to eq(@video_1.title)
      expect(@user.sorted_videos[3].thumbnail).to eq(@video_1.thumbnail)
    end
  end
end
