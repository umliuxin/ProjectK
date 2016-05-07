class ChangeIsActiveToGames < ActiveRecord::Migration
  def change
    change_column :games, :is_active , :boolean, null: false, default: true

  end
end
