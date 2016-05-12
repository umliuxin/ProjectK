class AddGameRoleToGamelogs < ActiveRecord::Migration
  def change
    add_column :gamelogs, :gamerole, :string
  end
end
