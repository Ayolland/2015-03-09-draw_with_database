require "pry"
require "sqlite3"
require "sinatra"
require "json"

get "/" do
  erb :draw
end