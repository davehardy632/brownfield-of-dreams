class UsersController < ApplicationController
  def show
    if current_user.token
      render locals: {
        facade: GithubFacade.new(current_user.token)
      }
    end
  end

  def new
    @user = User.new
  end

  def update
    user = User.find(params["id"])
    user.update_column(:active, true)
    flash[:message] = "Thank you your account is now activated!"
    redirect_to dashboard_path
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      UserActivationMailer.inform(current_user).deliver_now
      flash[:message] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
