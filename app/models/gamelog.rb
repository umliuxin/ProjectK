class Gamelog < ActiveRecord::Base
  validates :user_id, presence: true, numericality: true, inclusion:{ in: 0..User.last.id }
  validates :game_id, presence: true, numericality: true, inclusion:{ in: 0..Game.last.id }
  validates :is_active, inclusion:{in: [true, false],message: "%{value} is not a valid one"}
  validates :is_win, inclusion:{in: [true, false],message: "%{value} is not a valid win"}

  def exit_game
    # self.is_active = f
    update_attribute(:is_active , 'f')
  end


end
