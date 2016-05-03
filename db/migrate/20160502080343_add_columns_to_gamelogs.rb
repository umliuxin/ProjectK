class AddColumnsToGamelogs < ActiveRecord::Migration
  def change
    add_column :gamelogs, :is_active, :boolean, null: false, default: false
    add_column :gamelogs, :is_win, :boolean, null: false, default: false
  end
end
