user = User.create! email: 'ingo@orgizm.net', password: 'foobarbaz', password_confirmation: 'foobarbaz'

artists = []
10.times do 
  artists << Artist.create!(name: Faker::Name.last_name)
end

Album.tire.index.delete
Album.tire.create_elasticsearch_index

artists.each do |artist|
  albums = []
  rand(1..10).times do 
    albums << artist.albums.create!(name: Faker::Lorem.word)
    albums.last.users << user && albums.last.save if albums.count % 2 == 1
    rand(8..14).times do 
      t=albums.last.tracks.new(name: Faker::Lorem.word, duration: rand(32..678))
      t.duration_str
      t.save!
    end
  end
end
