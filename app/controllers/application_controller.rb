class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    !@current_user.nil? && current_user.role == 'admin'
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  # this does not hit the pry anywhere in rails s, tutorial videos still show titles properly
  # def tutorial_name(id)
  #   require 'pry'; binding.pry
  #   Tutorial.find(id).title
  # end

  def four_oh_four
    raise ActionController::RoutingError, 'Not Found'
  end
end
