# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cloverinteractive_session',
  :secret      => 'ca6e5b53a8fa9f5702591bd7b5743b87846b1af2d5eef81b7e2a3192354af2043fc66d80825f1b01c33ac02ea60a679b3e13e1ecd4fdbec37d9f76d9f6703e2e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
