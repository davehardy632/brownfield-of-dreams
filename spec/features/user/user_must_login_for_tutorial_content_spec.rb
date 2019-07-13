require 'rails_helper'

describe "As a user who is not logged in" do
  before :each do
    @user = create(:user)
    @tutorial_1 = create(:tutorial, classroom: true)
    @tutorial_2 = create(:tutorial, classroom: true)
    @tutorial_3 = create(:tutorial, classroom: false)
    @tutorial_4 = create(:tutorial, classroom: false)
  end
  it "I cannot see tutorials marked with 'classroom content' from the root path" do

    visit root_path

    expect(page).to have_content(@tutorial_3.title)
    expect(page).to have_content(@tutorial_4.title)
    expect(page).to_not have_content(@tutorial_1.title)
    expect(page).to_not have_content(@tutorial_2.title)
  end
end
