class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.has_videos?
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      redirect_to new_video_path
    end
  end
end
