class IdeasController < ApplicationController
  before_action :require_login

  def index
    @student = current_user
    @ideas = @student.cohort.ideas.select {|idea| idea.active?}
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

  def add_sessions
    @ideas = Idea.all
    @idea = Idea.find_by_id(params[:id])
    if session[:selection]
      if session[:selection].count >= 3
        flash[:error] = "Student can only vote 3 ideas each round."
        redirect_to ideas_path
      elsif !session[:selection].include?(@idea.id)
        session[:selection] << @idea.id
      else
        session[:selection].delete(@idea.id)
      end
    else
      session[:selection] = [@idea.id]
    end
    redirect_to ideas_path
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

#   def inactivate_unpopular_ideas
#     @student = current_user
#     @ideas = @student.cohort.ideas
#     @ideas.each do |idea|
#       if idea.votes.count == 0 && idea.rounds.voting_round > 1
#         idea.active = 0
#       end
#     end
#   end
end
