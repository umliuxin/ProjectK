module GameListHelper
  def join_in_game(params)
    gamelog = Gamelog.new(user_id: params[:userid], game_id: params[:gameid])
    ap gamelog
    ap gamelog.valid?
    ap gamelog.errors
    gamelog.save
    #return true if save sucessfully
  end
end
