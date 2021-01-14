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
            redirect_to '/'
        end
  end

  def omniauth
    user = User.create_from_omniauth(auth)
      if user.valid?
        session[:user_id] = user.id
        flash[:message] = "You have successfully signed in with Google, #{user.first_name}."
        redirect_to user_path(user)
      else
        flash[:message] = user.errors.full_messages.join(", ")
        redirect_to '/'
      end
  end

  def logout
    session.delete :user_id if session[:user_id]
    redirect_to '/'
  end

  private 

  def auth 
    request.env['omniauth.auth']
  end

  def sessions_params
    params.permit(:email, :password)
  end
end
