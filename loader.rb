require "pry"
require "pg"
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

#TODO - edit your user's sprites
#TODO - auto-name sprites

#TODO - larger palette + transparency
#TODO - sprite pagination
#TODO - responsive CSS
#TODO - rotate sprites
#TODO - flip sprites
#TODO - export as PNG
#TODO - email link for missing password