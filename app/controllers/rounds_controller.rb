class RoundsController < ApplicationController
  def create
    @cohort = Cohort.find_by_id(params[:cohort_id])
    @round = @cohort.rounds.create
    redirect_to current_user
  end

  def update
    @round = Round.find_by_id(params[:id])
    if @round.cohort.students.find { |student| student.current_access == "voting #{@round.voting_round}" }
      @round.cohort.students.each { |student| student.current_access = ""; student.save }
      redirect_to current_user
    else
      @round.cohort.students.each { |student| student.current_access = "voting #{@round.voting_round}"; student.save }
      redirect_to current_user
    end
  end
end