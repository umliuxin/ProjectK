class WelcomepageController < ApplicationController
  def show
  end
  def login
    # Get Username from user input
    puts params[:username]
    @user = User.new(name:params[:username])
    if @user.save
      redirect_to action:'show',controller:'game_list',username:params[:username]
    else
      redirect_to :action=>'show'
    end
    # Store it in session?
    # Session class should be in helper
    #redirect_to game_list
  end
end
