FactoryGirl.define do
  factory :user do
    email 'foo@bar.baz'
    password 'foobarbaz'
    password_confirmation 'foobarbaz'
  end

  factory :artist do
    name 'Gossenboss mit Zett'
  end

  factory :album do
    sequence(:name) { |n| "Schlechtes Album #{n}" }

    factory :album_with_tracks do
      ignore do
        tracks_count 23
      end

      after(:create) do |album, evaluator|
        FactoryGirl.create_list :track, evaluator.tracks_count, album: album
      end
    end

  end

  factory :track do
    sequence(:name){ |n| "Schlechter Track #{n}" }
    duration_str '02:03'
  end
end
