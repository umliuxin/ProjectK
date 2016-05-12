class AddNumOfActivePlayerToGames < ActiveRecord::Migration
  def change
      add_column :games, :num_of_active_player, :integer
  end
end
