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

  # AJAX call
  def killer_win
    # Check if the game can be end :: Game.is_active => f, Game.is_end => f
    if params[:is_win] && params[:is_win] === "true"
      is_killer_win = true
    elsif params[:is_win] && params[:is_win] === "false"
      is_killer_win = false
    else
      # flash[:danger] = 'Wrong Params'
      render :text => 'Wrong Params'
      return
    end

    ap is_killer_win

    @current_game = current_game
    ap @current_game
    if !@current_game
      flash[:danger] = "NO CURRENT GAME FOUND"
      forget_game
      redirect_to '/game_list'
      return
    end
    unless game_in_progress?
      render :text => 'GAME NOT IN PROGRESS'
      return
    end

    # Check if player is game host
    @current_user = current_user
    if !@current_user
      log_out
      redirect_to root_path
      return
    end

    unless is_game_host?
      render :text => 'YOU ARE NOT GAME HOST'
      return
    end
    # Update Game
    game_over_update_game
    # Update Gamelog
    game_over_update_gamelog(is_killer_win)

    render :nothing => true
  end


  def cancel_game
    render :nothing => true
  end

  def game_in_progress?
    #Game.is_active => f, Game.is_end => f
    @current_game.is_active === false && @current_game.is_end === false
  end

  def is_game_host?
    @current_game.host_id === @current_user.id
  end

  def game_over_update_game
    @current_game.is_end = true
    ap @current_game
    # unless @current_game.save
    #   render :text => 'SAVE FAILED'
    #   return
    # end
  end

  def game_over_update_gamelog(is_killer_win)
    ap Gamelog.where(:game_id => @current_game.id, :gamerole => ROLE_KILLER)
    ap '_____________________'
    ap Gamelog.where(:game_id => @current_game.id).where.not(:gamerole => ROLE_KILLER)
    Gamelog.where(:game_id => @current_game.id, :gamerole => ROLE_KILLER).update_all(:is_active => false , :is_win => is_killer_win )
    Gamelog.where(:game_id => @current_game.id).where.not(:gamerole => ROLE_KILLER).update_all(:is_active => false , :is_win => !is_killer_win )
  end

  def game_result()

  end


end
