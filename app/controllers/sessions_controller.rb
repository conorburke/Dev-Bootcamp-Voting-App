class SessionsController < ApplicationController
  def new
  end

  def create
    @user = Student.find_by_email(params[:session][:email]) || Teacher.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:access_code])
      session[:user_id] = @user.id
      session[:user_type] = @user.class.to_s
      flash[:sucess] = "User has successfully logged in."
      redirect_to ideas_path
    else
      flash[:fail] = "Email and password does not match."
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:user_type)
    redirect_to root_path
  end

  def view_session
    session.inspect
  end


  def add_sessions
    @ideas = Idea.all
    @idea = Idea.find_by_id(params[:id])
    if session[:selection]
      if !session[:selection].include?(@idea.id)
        session[:selection] << @idea.id
      else
        session[:selection].delete(@idea.id)
      end
    else
      session[:selection] = [@idea.id]
    end
    render 'ideas/index'
  end

end
