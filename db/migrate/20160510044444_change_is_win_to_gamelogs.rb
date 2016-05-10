class ChangeIsWinToGamelogs < ActiveRecord::Migration
  def change
    change_column :gamelogs, :is_win , :boolean, null: true, default: nil

  end
end
