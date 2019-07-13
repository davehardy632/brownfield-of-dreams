class InviteController < ApplicationController

  def new; end

  def create
    user_handle = params["handle"]
    github_service = GithubApiService.new(current_user.token)
    response = github_service.user_email(user_handle)
      if response[:email] != nil
        user_email = response[:email]
        InviteMailer.invite(user_email, user_handle, current_user).deliver_now
        flash[:notice] = "Successfully sent invite!"
        redirect_to dashboard_path
      else
        flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
        redirect_to dashboard_path
      end
    end
  end
