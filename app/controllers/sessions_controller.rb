class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:logout]

  def new
    if !logged_in?
      render :new
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.find_by(email: sessions_params[:email])
        if @user && @user.authenticate(sessions_params[:password])
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else
            redirect to '/'
        end
  end

  def logout
    session.delete :user_id if session[:user_id]
    redirect_to '/'
  end

  private 

  def sessions_params
    params.permit(:email, :password)
  end
end
