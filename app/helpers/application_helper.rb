module ApplicationHelper
  def log_in(user)
    session[USER_SESSION_ID] = user.id
    user.remember
    cookies.permanent.signed[USER_COOKIE_ID] = user.id
    cookies.permanent[USER_COOKIE_TOKEN] = user.remember_token
  end

  def current_user
    if (user_id = session[USER_SESSION_ID])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[USER_COOKIE_ID])
      user = User.find_by(id: user_id)
      if user && user.authtoken?(cookies[USER_COOKIE_TOKEN])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(USER_SESSION_ID)
    cookies.delete(USER_COOKIE_ID)
    cookies.delete(USER_COOKIE_TOKEN)
    forget_game
  end

  def current_game
    if game_id = session[GAME_SESSION_ID]
      ap game_id
      @current_game ||= Game.find_by(id: game_id)

      @current_game
    elsif game_id = cookies[GAME_COOKIE_ID]
      game ||= Game.find_by(id: game_id)
      remember_game(game)
      @current_game = game
    end
  end

  def in_game?
    !current_game.nil?
  end

  def remember_game(game)
    # this method is to store info in session and cookies
    session[GAME_SESSION_ID] = game.id
    cookies.permanent[GAME_COOKIE_ID] = game.id
  end

  def forget_game
    #this method is to forget game infor in session and cookies
    session.delete(GAME_SESSION_ID)
    cookies.delete(GAME_COOKIE_ID)
  end

  def current_gamelog

  end


end
