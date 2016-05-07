class WelcomepageController < ApplicationController
  def show
    # get current_user

    if logged_in?
      redirect_to '/game_list'
    end
  end

  def login
    # Get Username from user input
    @user = User.new(name:params[:username])
    if @user.save
      flash[:success] = 'Login Successful!'
      log_in @user
      redirect_to '/game_list'
    else
      flash.now[:danger] = "Login Failed!"
      render "show"
    end
  end

  def logout
    log_out if logged_in?
    redirect_to root_url
  end
end
