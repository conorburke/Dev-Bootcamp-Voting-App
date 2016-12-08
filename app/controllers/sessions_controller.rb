class SessionsController < ApplicationController
  def new
  end

  def create
    @user = Student.find_by_email(params[:session][:email]) # || Teacher.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:access_code])
      session[:user_id] = @user.id
      session[:user_type] = @user.class.to_s
      redirect_to @user, notice: "User has successfully logged in."
    else
      render :new, notice: "Email and password does not match."
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:user_type)
    redirect_to root_path
  end
end
