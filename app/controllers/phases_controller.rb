class PhasesController < ApplicationController
  def update
    @cohort = Cohort.find_by_id(params[:cohort_id])
    phase = @cohort.current_phase
    if phase == "ideas" && @cohort.students.find { |student| student.current_access == "ideas" }
      @cohort.next_phase
      @cohort.students.each { |student| student.current_access = ""; student.save }
      redirect_to current_user
    elsif phase == "ideas"
      @cohort.students.each { |student| student.current_access = "ideas"; student.save }
      redirect_to current_user
    end
  end
end
