module GameListHelper
  def join_in_game(params)
    @gamelog = Gamelog.new(user_id: params[:userid], game_id: params[:gameid])
    @game = Game.find_by(id: params[:gameid])
    if @game.num_of_active_player < @game.num_of_player && @game.is_active
      @game.add_one_player
      # TODO: consider to add a one more check for index number
      gamerole_index = @game.num_of_active_player
      ap '______________'
      ap @game.gameroles
      ap gamerole_index - 1
      ap @game.gameroles[gamerole_index-1]
      @gamelog.gamerole = @game.gameroles[gamerole_index-1]
      ap @gamelog
      ap @gamelog.valid?
      ap '______________'
      @gamelog.save
    else
      danger[:danger] = "number wrong"
      return false
    end

    #return true if save sucessfully
  end
end
