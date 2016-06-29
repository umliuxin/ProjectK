class AddIsDeadToGames < ActiveRecord::Migration
  def change
    add_column :games, :is_anyone_exit, :boolean, default: false
  end
end
