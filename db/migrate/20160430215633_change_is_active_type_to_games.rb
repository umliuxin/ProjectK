class ChangeIsActiveTypeToGames < ActiveRecord::Migration
  def change
    change_column :games , :is_active, :integer
  end
end
