class GithubSessionsController < ApplicationController

  def create
    token = current_user.from_omniauth(request.env["omniauth.auth"])
    current_user.update_column(:token, token)

    redirect_to dashboard_path
  end
end
