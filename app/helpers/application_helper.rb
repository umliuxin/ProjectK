module ApplicationHelper
  def log_in(user)
    session[:username] = user.name
    user.remember
    cookies.permanent.signed[:username] = user.name
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # ap 'running current_user'
    if (user_name = session[:username])
      @current_user ||= User.find_by(name: session[:username])
    elsif (user_name = cookies.signed[:username])
      user = User.find_by(name: user_name)
      if user && user.authtoken?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:username)
    cookies.delete(:username)
    cookies.delete(:remember_token)
    # @username=nil
  end

  def current_game
    if game_id = session[:gameid]
      @current_game ||= Game.find_by(id: game_id)
    elsif game_id = cookies[:gameid]
      remember_game(game)
      game ||= Game.find_by(id: game_id)
      @current_game = game
    end
  end

  def in_game?
    !current_game.nil?
  end

  def remember_game(game)
    # this method is to store info in session and cookies
    session[:gameid] = game.id
    cookies.permanent[:gameid] = game.id
  end

  def forget_game
    #this method is to forget game infor in session and cookies
    session.delete(:gameid)
    cookies.delete(:gameid)
    # @current_user = nil
  end

  def current_gamelog
  
  end


end
