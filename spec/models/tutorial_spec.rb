require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  before :each do
    @tutorial_1 = create(:tutorial, classroom: true)
    @tutorial_2 = create(:tutorial, classroom: true)
    @tutorial_3 = create(:tutorial, classroom: false)
    @tutorial_4 = create(:tutorial, classroom: false)
    
    @video1 = create(:video, tutorial_id: @tutorial_2.id)
  end

  describe "Class methods" do
    it ".non_classroom" do
      expect(Tutorial.non_classroom).to eq([@tutorial_3, @tutorial_4])
    end
  end

  describe "Instance methods" do
    it "#has_videos?" do
      expect(@tutorial_1.has_videos?).to eq(false)
      expect(@tutorial_2.has_videos?).to eq(true)
      end
    end
  end
end
