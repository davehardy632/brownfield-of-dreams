require 'rails_helper'

describe "As a user who is not logged in" do
  before :each do
    @user = create(:user)
    @tutorial_1 = create(:tutorial, classroom: true)
    @tutorial_2 = create(:tutorial, classroom: true)
    @tutorial_3 = create(:tutorial, classroom: false)
  end
  it "I cannot see tutorials marked with 'classroom content'" do

    visit root_path

    expect(page).to have_content(@tutorial_3.title)
    expect(page).to_not have_content(@tutorial_1.title)
    expect(page).to_not have_content(@tutorial_2.title)

    visit tutorials_path

    expect(page).to have_content(@tutorial_3.title)
    expect(page).to_not have_content(@tutorial_1.title)
    expect(page).to_not have_content(@tutorial_2.title)

    visit tutorial_path(@tutorial_1)

    expect(page).to_not have_content(@tutorial_1.title)
  end
end



# Currently all tutorials are visible to anyone. We want to make tutorials marked as "classroom content" viewable only if the user is logged in.
#
# The tutorials table has a boolean column for classroom that should be used for this story.
