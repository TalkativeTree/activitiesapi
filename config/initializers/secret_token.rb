# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4 
# requires secret_key_base or secret_token to be defined, otherwise an 
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
Activitiesapi::Application.config.secret_token = '791247f8946f04e9f3ae66ce719dec2446d4733ad4e8cdad2c948c8db0c35927d0883c2c482e25701472e6335cffebf7280876792ea7972c4d7cc3bc3e794ce4'
Activitiesapi::Application.config.secret_key_base = 'c41fe284668d0244afe4a158fa18e0cb5a9c1740cb664a9b976f9e5d753ab8c20a2e77a71554fe8e625c0c32442354d6ce1ea68559381aca8fab41c5331fb278'
