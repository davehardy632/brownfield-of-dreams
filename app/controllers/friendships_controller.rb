class FriendshipsController < ApplicationController

  def create
    new_friend = User.find_by(handle: params["format"])
    current_user.friends << new_friend
    redirect_to dashboard_path
  end
end
