# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Crate::Application.config.secret_key_base = ENV['SECRET_TOKEN']#'37e1c948a9408146fec06ed2e8e7b0857840fe86a5dda0b4fffe85ddb33fe8f63f17d9dcddad7f7744ab8c9441595c906fb4637d46626470f5895c4b9af4dc54'
