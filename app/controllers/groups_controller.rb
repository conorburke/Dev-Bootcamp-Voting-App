class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def create
    p request
    redirect_to groups_path
  end

end
