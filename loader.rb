require "pry"
require "sqlite3"
require "sinatra"
require "sinatra/activerecord"
require "json"

require_relative "database/database_setup.rb"

require_relative "models/sprite.rb"

require_relative "controllers/sprites.rb"