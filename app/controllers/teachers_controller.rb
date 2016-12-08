class TeachersController < ApplicationController
  def show
    @cohorts = current_user.cohorts.sort_by { |cohort| cohort.created_at }.reverse
  end
end
