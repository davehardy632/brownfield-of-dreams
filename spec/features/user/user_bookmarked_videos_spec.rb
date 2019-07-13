require 'rails_helper'

RSpec.describe 'as a logged in user' do
  context 'when I visit my dashboard' do
    it 'can see a list of their bookmarked videos in order' do
      user = create(:user)

      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)

      video_1 = create(:video, tutorial: tutorial_2, position: 1, thumbnail: 'https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg')
      video_2 = create(:video, tutorial: tutorial_1, position: 1, thumbnail: 'https://i.ytimg.com/vi/WMgDD2lU5nY/hqdefault.jpg')
      video_3 = create(:video, tutorial: tutorial_1, position: 0, thumbnail: 'https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg')
      video_4 = create(:video, tutorial: tutorial_2, position: 0, thumbnail: 'https://i.ytimg.com/vi/cv1VQ_9OqvE/hqdefault.jpg')

      user_video_1 = UserVideo.create!(user: user, video: video_1)
      user_video_2 = UserVideo.create!(user: user, video: video_2)
      user_video_3 = UserVideo.create!(user: user, video: video_3)
      user_video_4 = UserVideo.create!(user: user, video: video_4)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # When I visit '/dashboard'
      visit dashboard_path
      save_and_open_page
      # require 'pry'; binding.pry
      # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
      within('.bookmarks') do
        # And they should be organized by which tutorial they are a part of
        # And the videos should be ordered by their position
        expect(page.all('h5')[0]).to have_content(tutorial_1.title)
        expect(page.all("li")[0]).to have_content(video_3.title)
        expect(page.all('h5')[1]).to have_content(tutorial_1.title)
        expect(page.all("li")[1]).to have_content(video_2.title)

        expect(page.all('h5')[2]).to have_content(tutorial_2.title)
        expect(page.all("li")[2]).to have_content(video_4.title)
        expect(page.all('h5')[3]).to have_content(tutorial_2.title)
        expect(page.all("li")[3]).to have_content(video_1.title)
      end
    end
  end
end
