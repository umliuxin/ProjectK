class GameRoomController < ApplicationController

  def show
    @current_user = current_user
    if !@current_user
      log_out
      redirect_to root_path
      return
    end
    @current_game = current_game
    if !@current_game
      flash[:danger] = "NO GAME DATA FOUND"
      forget_game
      redirect_to '/game_list'
      return
    end
    @current_gamelog = Gamelog.find_by(user_id: @current_user.id, game_id: @current_game.id)

  end

  def exit
    if logged_in? && in_game?
      @current_user = current_user
      @current_game = current_game
      @current_gamelog = Gamelog.find_by(game_id: @current_game[:id], user_id: @current_user[:id])
      @current_gamelog.exit_game
    end

    if in_game?
      forget_game
    end
    redirect_to '/game_list'
  end


end
