class InviteController < ApplicationController

  def new

  end

  def create
    user_handle = params["email"]
    github_service = GithubApiService.new(current_user.token)
    response = github_service.user_email(user_handle)
    user_email = response[:email]
    InviteMailer.invite(user_email, user_handle, current_user).deliver_now
    redirect_to dashboard_path
  end
end
