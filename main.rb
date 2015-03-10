require "pry"
require "sqlite3"
require "sinatra"
require "json"

DATABASE = SQLite3::Database.new("sprites.db")
DATABASE.results_as_hash = true

require_relative "database_setup.rb"

get "/" do
  erb :draw
end

get "/save" do
end

get "/load/:id" do
end

