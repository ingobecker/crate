class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :duration, null: false
      t.integer :position, null: false
      t.references :album

      t.timestamps
    end

    add_index :tracks, :name
  end
end
