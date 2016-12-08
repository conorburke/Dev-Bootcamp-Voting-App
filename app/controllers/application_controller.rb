class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:user_type] == "Student"
      Student.find_by_id(session[:user_id])
    else
      # Teacher.find_by_id(session[:user_id])
    end
  end

  helper_method :current_user
end
