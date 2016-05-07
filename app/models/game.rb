class Game < ActiveRecord::Base
  validates :num_of_player, presence: true, numericality: true, inclusion: { in: GAME_MIN_PLAYER_INCLUSIVE..GAME_MAX_PLAYER_INCLUSIVE }
  validates :host_id, presence: true, numericality: true, inclusion:{ in: 1..User.last.id }
  validates :is_active, inclusion: {in: [true, false],message: "%{value} is not a valid one"}
  validates :access_code, length: { maximum: 20 }
  validates :gameroles,presence: true, length: {maximum:GAME_MAX_PLAYER_INCLUSIVE,minimum:GAME_MIN_PLAYER_INCLUSIVE},format: { :with => /^[012]+$/, :multiline=> true }
end
