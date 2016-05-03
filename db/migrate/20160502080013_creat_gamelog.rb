class CreatGamelog < ActiveRecord::Migration
  def change
    create_table :gamelogs do |t|
      t.integer :game_id, :user_id

      t.timestamps null: false
    end
  end
end
