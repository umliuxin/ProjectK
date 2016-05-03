class GameListController < ApplicationController
  include GameListHelper

  def show
    @current_user = current_user
    if !@current_user
      redirect_to :action=>'show' , :controller=>'welcomepage'
    end
  end

  def create_game
    @current_user = current_user
    if @current_user.id == params[:host_id].to_i
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
        unless join_in(@game.id, @current_user.id)
          flash[:danger] = 'Hosting join in failed!'
          redirect_to action:'show'
        end
        remember_game(@game)
        redirect_to action:'show', controller:'game_room'
      else
        flash[:danger] = 'Game Creation Failed!'
        redirect_to action:'show'
      end
    else
      log_out
      flash[:danger] = 'User Auth Failed!'
      redirect_to root_path
    end



  end
end
