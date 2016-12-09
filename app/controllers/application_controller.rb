class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include CanCan::ControllerAdditions

  def current_user
    if session[:user_type] == "Student"
      Student.find_by_id(session[:user_id])
    else
      Teacher.find_by_id(session[:user_id])
    end
  end

  def can_vote?
    if current_user.is_a? Student
      return false unless current_user.current_access.include? "voting"
      votes_this_round = current_user.votes_this_round
      votes_this_round.count < 3
    end
  end

  def voted_idea_this_round?(idea)
    if current_user.is_a? Student
      ideas_voted_this_round = current_user.votes_this_round.map { |vote| vote.idea }
      ideas_voted_this_round.include? idea
    end
  end

  helper_method :current_user, :can_vote?, :voted_idea_this_round?
end
