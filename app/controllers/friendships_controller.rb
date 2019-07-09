class FriendshipsController < ApplicationController

  def create
    new_friend = User.find_by(handle: params["format"])
    new_friendship = Friendship.create(user_id: current_user.id, friend_id: new_friend.id)
    redirect_to dashboard_path
  end
end
