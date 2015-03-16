require "pry"
require "sqlite3"
require "sinatra"
require "sinatra/activerecord"
require "json"
require "bcrypt"

require_relative "database/database_setup.rb"

require_relative "models/sprite.rb"
require_relative "models/user.rb"

require_relative "controllers/sprites.rb"
require_relative "controllers/nav.rb"

enable :sessions