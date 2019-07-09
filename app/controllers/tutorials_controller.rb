class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.has_videos?
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    elsif current_admin?
      redirect_to admin_tutorial_videos_path
    else
      flash[:alert] = 'This tutorial has no videos at this time.'
      redirect_to root_path
    end
  end
end
