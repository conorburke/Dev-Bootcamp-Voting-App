class HomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user if current_user.is_a? Teacher
      redirect_to ideas_path if current_user.is_a? Student
    end
  end
end
