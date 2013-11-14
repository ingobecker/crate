class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :artists, :name
  end
end
