class Game < ActiveRecord::Base

  validates :num_of_player, presence: true, numericality: true, inclusion: { in: GAME_MIN_PLAYER_INCLUSIVE..GAME_MAX_PLAYER_INCLUSIVE }
  validates :host_id, presence: true, numericality: true
  validates :is_active, inclusion: {in: [true, false],message: "%{value} is not a valid one"}
  validates :access_code, length: { maximum: 20 }
  validates :gameroles,presence: true, length: {maximum:GAME_MAX_PLAYER_INCLUSIVE,minimum:GAME_MIN_PLAYER_INCLUSIVE},format: { :with => /^[012]+$/, :multiline=> true }

  def random_game_role
    self.gameroles = self.gameroles.split('').shuffle().join('')
  end

  def add_one_player
    self.num_of_active_player = self.num_of_active_player + 1
    self.check_if_full
    self.update_active_player
  end

  def update_active_player
    update_attribute(:num_of_active_player,self.num_of_active_player)
  end

  def check_if_full
    if self.num_of_player === self.num_of_active_player
      update_attribute(:is_active, 'f')
    end
  end

  def player_exit
    if !self.is_anyone_exit
      update_attribute(:is_anyone_exit, 't')
      update_attribute(:is_end,'t')
    end
  end

  def create_next_game
      #handle game creation
      create_params = {
        host_id: self.host_id,
        number_of_player: self.num_of_player,
        access_code: self.access_code,
        is_active: true,
        gameroles: GAME_ROLE[self.num_of_player.to_s.to_sym]
      }
      @game = Game.new(host_id: create_params[:host_id],
            num_of_player: create_params[:number_of_player],
            is_active: create_params[:is_active],
            access_code: create_params[:access_code],
            gameroles: create_params[:gameroles])

      @game.random_game_role
      @game.save
      @game
  end

  def get_next_game
    @latest_game = Game.where(host_id: self.host_id).order('created_at DESC').first
    if @latest_game.id != self.id
      @latest_game
    else
      return false
    end
  end
end
