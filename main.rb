require "pry"
require "sqlite3"
require "sinatra"
require "json"

require_relative "database_setup.db"

DATABASE = SQLite3::Database.new("sprites.db")
DATABASE.results_as_hash = true

get "/" do
  erb :draw
end


