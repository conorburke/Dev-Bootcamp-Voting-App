class PhasesController < ApplicationController
  def update
    @cohort = Cohort.find_by_id(params[:cohort_id])
    phase = @cohort.current_phase
    if phase == "ideas" && @cohort.students.find { |student| student.current_access == "ideas" }
      @cohort.next_phase
      @cohort.students.each { |student| student.current_access = ""; student.save }
    elsif phase == "ideas"
      @cohort.students.each { |student| student.current_access = "ideas"; student.save }
    elsif phase == "voting"
      @cohort.next_phase
    elsif phase == "preference" && @cohort.students.find { |student| student.current_access == "preference" }
      @cohort.next_phase
      @cohort.students.each { |student| student.current_access = ""; student.save }
    elsif phase == "preference"
      @cohort.students.each { |student| student.current_access = "preference"; student.save }
    end
    redirect_to @cohort
  end
end
