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

end
