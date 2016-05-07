module GameListHelper
  def join_in_game(params)
    gamelog = Gamelog.new(user_id: params[:userid], game_id: params[:gameid])
    gamelog.save
    #return true if save sucessfully
  end
end
