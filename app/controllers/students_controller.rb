class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    cohort = Cohort.find_by_id(params[:cohort_id]) || Cohort.new
    student = cohort.students.create(student_params)

    if student.valid?
      flash[:success] = "Student #{student.full_name} was successfully registered."
      redirect_to cohort
    else
      flash[:fail] = student.errors.full_messages.first
      redirect_to new_cohort_student_path
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email)
  end
end
