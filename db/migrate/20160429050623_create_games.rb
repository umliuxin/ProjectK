class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :num_of_player,:host_id
      t.binary :is_active
      t.string :access_code
      t.timestamps null: false
    end
  end
end
