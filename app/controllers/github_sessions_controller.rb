class GithubSessionsController < ApplicationController
  def create
    token = current_user.return_token(request.env["omniauth.auth"])
    handle = current_user.return_handle(request.env["omniauth.auth"])
    current_user.update_column(:token, token)
    current_user.update_column(:handle, handle)
    redirect_to dashboard_path
  end
end
