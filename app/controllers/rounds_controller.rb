class RoundsController < ApplicationController
  def create
    @cohort = Cohort.find_by_id(params[:cohort_id])
    @round = @cohort.rounds.create
    redirect_to current_user
  end

  def update
    @round = Round.find_by_id(params[:id])
    # Disable Voting
    if @round.cohort.students.find { |student| student.current_access == "voting #{@round.voting_round}" }
      @round.cohort.students.each { |student| student.current_access = ""; student.save }
      active_ideas = @round.cohort.ideas.select { |idea| idea.active? }
      ordered_ideas = active_ideas.sort_by { |idea| idea.vote_count(@round) }.reverse
      limit = [4, (ordered_ideas.count / 2)].max
      ordered_ideas[limit..-1].each do |idea|
        idea.update_attribute(:active, 0)
      end
      redirect_to current_user
    # Enable Voting
    else
      @round.cohort.students.each { |student| student.current_access = "voting #{@round.voting_round}"; student.save }
      redirect_to current_user
    end
  end
end
