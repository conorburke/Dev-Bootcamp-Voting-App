class CohortsController < ApplicationController
  def create
  end

  def show
    @cohort = Cohort.find_by_id(params[:id])
    @students = @cohort.students
    @phase = @cohort.current_phase
  end
end
