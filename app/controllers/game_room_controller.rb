class GameRoomController < ApplicationController
  include GameListHelper

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
    if @current_gamelog.is_win != nil
      flash[:success] = 'Game result :' + @current_gamelog.is_win.to_s
    end
  end

  def exit_game
    if logged_in? && in_game?
      @current_user = current_user
      @current_game = current_game
      @current_game.player_exit
      @current_gamelog = Gamelog.find_by(game_id: @current_game[:id], user_id: @current_user[:id])
      @current_gamelog.exit_game
    end

    if in_game?
      forget_game
    end
    redirect_to '/game_list'
  end

  def game_over
    # Check if the game can be end :: Game.is_active => f, Game.is_end => f
    if params[:is_win] && params[:is_win] === "true"
      is_killer_win = true
    elsif params[:is_win] && params[:is_win] === "false"
      is_killer_win = false
    else
      flash[:danger] = 'Wrong Params'
      redirect_to '/game_room'
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
      flash[:danger] = 'GAME NOT IN PROGRESS'
      redirect_to '/game_room'
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

    redirect_to '/game_room'
  end

  def next_game
    @current_user = current_user
    @current_game = current_game
    if is_game_host?
      if @current_game.is_end
        @new_game = @current_game.create_next_game
        if @new_game.id
          join_in_game({gameid: @new_game.id, userid: @current_user.id})
          remember_game(@new_game)
        else
          flash[:danger] = 'Create next game failed'
        end
      else
        flash[:danger] = 'Game is not end yet'
      end

    else
      if @new_game = @current_game.get_next_game
        # join new game
        join_in_game({gameid: @new_game.id, userid: @current_user.id})
        remember_game(@new_game)
        @current_gamelog = Gamelog.find_by(user_id: @current_user.id, game_id: @current_game.id)
        flash[:success] = 'Last Game Result :' + @current_gamelog.is_win.to_s
      else
        flash[:danger] = 'No new game found'
      end

    end
    redirect_to '/game_room'
  end


  def game_in_progress?
    #Game.is_active => f, Game.is_end => f
    @current_game.is_active === false
  end

  def is_game_host?
    @current_game.host_id === @current_user.id
  end

  def game_over_update_game
    # Move to Model
    @current_game.is_end = true
    unless @current_game.save
      flash[:danger] = 'SAVE FAILED'
      redirect_to '/game_room'
      return
    end
  end

  def game_over_update_gamelog(is_killer_win)
    Gamelog.where(:game_id => @current_game.id, :gamerole => ROLE_KILLER).update_all(:is_active => false , :is_win => is_killer_win )
    Gamelog.where(:game_id => @current_game.id).where.not(:gamerole => ROLE_KILLER).update_all(:is_active => false , :is_win => !is_killer_win )
  end



end
