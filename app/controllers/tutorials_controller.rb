class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.videos?
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      flash[:alert] = 'This tutorial has no videos at this time.'
      redirect_to root_path
    end
  end
end
