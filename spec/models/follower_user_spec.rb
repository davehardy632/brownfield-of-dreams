require 'rails_helper'

RSpec.describe FollowerUser do
  before :each do
    @follower = FollowerUser.new({login: "Loomus", html_url: 'test_url'})
  end

  it 'exists' do
    expect(@follower).to be_a FollowerUser
  end

  it 'has attributes' do
    expect(@follower.handle).to eq('Loomus')
    expect(@follower.url).to eq('test_url')
  end
end