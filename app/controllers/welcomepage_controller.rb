class WelcomepageController < ApplicationController
  def show
  end
  def login
    puts 'abc'
    redirect_to :action => 'show',:controller=>'game_list'
  end
end
