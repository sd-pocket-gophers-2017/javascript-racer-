class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.index :name, unique: true

      t.timestamps
    end
  end
end
