class CohortsController < ApplicationController
  def new
    @cohort = Cohort.new
    @city = current_user.city
  end

  def create
    city = current_user.city || City.new
    @cohort = city.cohorts.create(cohort_params)

    if @cohort.valid?
      flash[:success] = "Cohort successfully created."
      redirect_to current_user
    else
      flash[:fail] = @cohort.errors.full_messages.first
      redirect_to new_cohort_path
    end
  end

  def show
    @cohort = Cohort.find_by_id(params[:id])
    @students = @cohort.students
    @phase = @cohort.current_phase
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name)
  end
end
