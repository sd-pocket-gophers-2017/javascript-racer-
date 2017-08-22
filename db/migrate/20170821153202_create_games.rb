class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :url, unique: true, null: false
      t.integer :winner_id

      t.timestamps
    end
  end
end
