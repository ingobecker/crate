class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :tracks_count, default: 0, nil: false
      t.references :artist

      t.timestamps
    end

    add_index :albums, :name
  end
end
