require 'rails_helper'

RSpec.describe Repo do
  before :each do
    @repo = Repo.new({name: "1901-mod2tunes", html_url: 'test_url'})
  end

  it 'exists' do
    expect(@repo).to be_a Repo
  end

  it 'has attributes' do
    expect(@repo.name).to eq('1901-mod2tunes')
    expect(@repo.url).to eq('test_url')
  end
end