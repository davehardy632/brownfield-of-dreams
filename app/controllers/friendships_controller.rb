class FriendshipsController < ApplicationController
  def create
    if User.find_by(handle: params['handle'])
      new_friend = User.find_by(handle: params['handle'])
      current_user.friends << new_friend
    else
      flash[:message] = 'Invalid User Id'
    end
    redirect_to dashboard_path
  end
end
