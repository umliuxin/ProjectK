class GameRoomController < ApplicationController
  def init

  end

  def show
    if (gameid = session[:gameid])
      @current_game ||= Game.find_by(id: gameid)
    elsif (gameid = cookies[:gameid])
      @current_game ||= Game.find_by(id: gameid)
    end
    ap @current_game
  end
end
