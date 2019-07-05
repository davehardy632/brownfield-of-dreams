class GithubSessionsController < ApplicationController

  def create
    if user = User.find(current_user.id)
      token = user.from_omniauth(request.env["omniauth.auth"])
      current_user.update_column(:token, token)
    end
    redirect_to dashboard_path
  end

end
