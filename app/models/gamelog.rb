class Gamelog < ActiveRecord::Base
  validates :user_id, presence: true, numericality: {greater_than: 0}
  validates :game_id, presence: true, numericality: {greater_than: 0}
  validates :is_active, inclusion:{in: [true, false],message: "%{value} is not a valid one"}
  validates :is_win, inclusion:{in: [true, false],message: "%{value} is not a valid win"}

  def exit_game
    update_attribute(:is_active , 'f')
  end


end
