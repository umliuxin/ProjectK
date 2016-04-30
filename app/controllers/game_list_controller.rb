class GameListController < ApplicationController
  def show
    if !current_user && !@current_user
      redirect_to :action=>'show' , :controller=>'welcomepage'
    end
  end

  def create_game
    #handle game creation
    ap '_______'

    create_params = {
      host_id:params[:host_id].to_i,
      number_of_player:params[:numOfPlayer].to_i,
      access_code:params[:accessCode]
    }
    ap create_params
    ap '_______'
    render :text => params
  end
end
