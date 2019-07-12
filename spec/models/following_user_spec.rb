require 'rails_helper'

RSpec.describe FollowingUser do
  before :each do
    @follower = FollowingUser.new({login: "magic-man", html_url: 'test_url'})
  end

  it 'exists' do
    expect(@follower).to be_a FollowingUser
  end

  it 'has attributes' do
    expect(@follower.handle).to eq('magic-man')
    expect(@follower.url).to eq('test_url')
  end
end