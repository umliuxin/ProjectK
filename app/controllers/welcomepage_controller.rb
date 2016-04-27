class WelcomepageController < ApplicationController
  def show
  end
  def login
    # Get Username from user input
    puts params[:username]
    # Store it in session?
    # Session class should be in helper
    #redirect_to game_list
    redirect_to action:'show',controller:'game_list',username:params[:username]
  end
end
