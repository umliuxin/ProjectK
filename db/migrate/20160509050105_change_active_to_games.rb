class ChangeActiveToGames < ActiveRecord::Migration
  def change
    change_column :games, :num_of_active_player , :integer, default: 0
  end
end
