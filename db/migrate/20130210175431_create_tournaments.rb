class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :match_id
      t.integer :round
      t.string :status

      t.timestamps
    end
  end
end
