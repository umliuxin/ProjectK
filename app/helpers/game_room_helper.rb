module GameRoomHelper
  def is_game_host?
    @current_game.host_id === @current_user.id
  end
end
