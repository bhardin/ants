class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player_id
      t.integer :tournament_id

      t.integer :player_1_game_1_score
      t.integer :player_1_game_2_score
      t.integer :player_2_game_1_score
      t.integer :player_2_game_2_score

      t.string  :status
      t.integer :round

      t.timestamps
    end
  end
end
