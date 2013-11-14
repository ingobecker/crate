FactoryGirl.define do
  factory :user do
    email 'foo@bar.baz'
    password 'foobarbaz'
    password_confirmation 'foobarbaz'
  end
end
