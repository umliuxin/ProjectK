class GameListController < ApplicationController
  def show
    @current_user = current_user
    ap '_____flash show_____'
    ap flash
    ap'________________________'
    if !@current_user
      redirect_to :action=>'show' , :controller=>'welcomepage'
    end
    ap '_____game list show_____'
    ap @current_user
    ap'________________________'
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
      ap '____Running Creating game ___'
      ap create_params
      ap '______end creating game ________'

      @game = Game.new(host_id: create_params[:host_id],
            num_of_player: create_params[:number_of_player],
            is_active: create_params[:is_active],
            access_code: create_params[:access_code])

      if @game.save
        flash[:success] = 'Game Created!'
        # Join in the game after creation
        game_id = @game.id
        ap @current_user
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
