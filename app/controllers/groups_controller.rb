class GroupsController < ApplicationController
  def index
    @cohort = Cohort.find_by_id(params[:cohort_id])
    @groups = @cohort.groups
  end

  # def create
  #   p request
  #   redirect_to groups_path
  # end

  def update
    if request.xhr?
      # p params
      # p @var = JSON.parse(params["group-11"])
    end
  end

end
