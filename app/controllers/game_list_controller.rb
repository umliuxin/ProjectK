class GameListController < ApplicationController
  include GameListHelper

  def show
    @current_user = current_user
    if !@current_user
      log_out
      redirect_to root_path
    end

    if current_game
      # redirect_to :action=>'show' , :controller=>'game_room'
      redirect_to '/game_room'
    end
  end

  def create_game
    @current_user = current_user

    unless @current_user.id == params[:host_id].to_i
      log_out
      flash[:danger] = 'User Auth Failed!'
      redirect_to root_path
      return
    end

    #handle game creation
    create_params = {
      host_id: params[:host_id].to_i,
      number_of_player: params[:numOfPlayer].to_i,
      access_code: params[:accessCode],
      is_active: 1
    }

    @game = Game.new(host_id: create_params[:host_id],
          num_of_player: create_params[:number_of_player],
          is_active: create_params[:is_active],
          access_code: create_params[:access_code])

    if @game.save
      flash[:success] = 'Game Created!'
      # Join in the game after creation
      ap '__Joining game as a host__'
      unless join_in_game(@game.id, @current_user.id)
        flash[:danger] = 'Hosting join in failed!'
        redirect_to action:'show'
      end
      remember_game(@game)
      redirect_to '/game_room'
      return
    else
      flash[:danger] = 'Game Creation Failed!'
      redirect_to action:'show'
      return
    end
  end

  def join_game
    ap params
    # should login

    unless @current_user = current_user
      flash[:danger] = 'no current user'
      redirect_to root_path
      return
    end
    game_id = params[:game_id].to_i
    # game should exist
    unless @game = Game.find_by(id: game_id)
      flash[:danger] = 'game not exists'
      redirect_to action:'show'
      return
    end
    # game should be active
    unless @game.is_active === 1
      flash[:danger] = 'Game not active'
      redirect_to action:'show'
      return
    end
    # game should have slot
    @gamelogs = Gamelog.where(game_id: game_id)
    unless @gamelogs.length < @game.num_of_player
      flash[:danger] = ' No slot'
      redirect_to action:'show'
      return
    end
    # id should not already in game
    @is_exist = Gamelog.where(game_id: game_id, user_id: @current_user.id)
    unless @is_exist.length === 0
      flash[:danger] = 'Already added'
      redirect_to action:'show'
      return
    end

    unless join_in_game(@game.id, @current_user.id)
      flash[:danger] = 'Guest join in failed!'
      redirect_to action:'show'
    end
    remember_game(@game)
    redirect_to action:'show', controller:'game_room'
  end


end
