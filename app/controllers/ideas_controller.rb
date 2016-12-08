class IdeasController < ApplicationController
  before_action :require_login

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end

  def create
    @student = current_user
    @idea = @student.ideas.build(idea_params)
    if @idea.save
      redirect_to ideas_path
    else
      render 'new'
    end
  end

  private

    def idea_params
      params.require(:idea).permit(:title)
    end

    def require_login
      unless current_user
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_session_path
      end
    end
end
