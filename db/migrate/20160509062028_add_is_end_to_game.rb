class AddIsEndToGame < ActiveRecord::Migration
  def change
    add_column :games, :is_end, :boolean, default: false
  end
end
