User.create! email: 'ingo@orgizm.net', password: 'foobarbaz', password_confirmation: 'foobarbaz'

artists = []
10.times do 
  artists << Artist.create!(name: Faker::Name.last_name)
end

artists.each do |artist|
  albums = []
  rand(1..10).times do 
    albums << artist.albums.create!(name: Faker::Lorem.word)
    rand(8..14).times do 
      albums.last.tracks.create!(name: Faker::Lorem.word, duration: 420)
    end
  end
end
