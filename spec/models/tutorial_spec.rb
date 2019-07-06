require 'rails_helper'

RSpec.describe Tutorial, type: :model do

  describe "Class methods" do
    it ".non_classroom" do
      tutorial_1 = create(:tutorial, classroom: true)
      tutorial_2 = create(:tutorial, classroom: true)
      tutorial_3 = create(:tutorial, classroom: false)
      tutorial_4 = create(:tutorial, classroom: false)

      expect(Tutorial.non_classroom).to eq([tutorial_3, tutorial_4])
    end
  end
end
