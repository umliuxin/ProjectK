module GameListHelper
  def join_in(game_id, user_id)
    ap '_____join in helper______'
    ap game_id
    ap user_id
    ap '_______________________'
    gamelog = Gamelog.new(user_id: user_id, game_id: game_id)
    gamelog.save
    #return true if save sucessfully
  end

  def remember_game(game)
    # this method is to store info in session and cookies
    session[:gameid] = game.id
    cookies.permanent[:gameid] = game.id
  end

  def exit_game(game)
    #this method is to forget game infor in session and cookies
    session.delete(:gameid)
    cookies.delete(:gameid)
  end
end
