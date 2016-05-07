class AddGameRoleToGames < ActiveRecord::Migration
  def change
    add_column :games, :gameroles, :string
  end
end
