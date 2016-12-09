class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def create
    p request
    redirect_to groups_path
  end

  def update
    if request.xhr?
      # p params
      # p @var = JSON.parse(params["group-11"])
    end
  end

end
