class UpdateDefaulyValueToGamelog < ActiveRecord::Migration
  def change
    change_column :gamelogs, :is_active , :boolean, null: false, default: true
  end
end
