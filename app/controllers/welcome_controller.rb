class WelcomeController < ApplicationController
  def index
    if params[:tag] && !current_user.nil?
      @tutorials = Tutorial.tagged_with(params[:tag])
                           .paginate(page: params[:page], per_page: 5)
    elsif current_user
      @tutorials = Tutorial.all
                           .paginate(page: params[:page], per_page: 5)
    elsif current_user.nil?
      @tutorials = Tutorial.non_classroom
                           .paginate(page: params[:page], per_page: 5)
    end
  end
end
