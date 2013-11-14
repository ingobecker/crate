class CreateAlbumsUser < ActiveRecord::Migration
  def change
    create_table :albums_users do |t|
      t.integer :album_id
      t.integer :user_id
    end
  end
end
