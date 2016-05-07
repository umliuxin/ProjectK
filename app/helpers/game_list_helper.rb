module GameListHelper
  def join_in_game(game_id, user_id)
    ap '_____join in helper______'
    ap game_id
    ap user_id
    ap '_______________________'
    gamelog = Gamelog.new(user_id: user_id, game_id: game_id)
    gamelog.save
    #return true if save sucessfully
  end
end
