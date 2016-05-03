class Game < ActiveRecord::Base
  validates :num_of_player, presence: true, numericality: true, inclusion: { in: GAME_MIN_PLAYER_INCLUSIVE..GAME_MAX_PLAYER_INCLUSIVE }
  validates :host_id, presence: true, numericality: true, inclusion:{ in: 1..User.last.id }
  validates :is_active, presence: true, numericality: true, inclusion: {in: 0..1 }
  validates :access_code, length: { maximum: 20 }
end
