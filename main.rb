require "pry"
require "sqlite3"
require "sinatra"
require "json"

DATABASE = SQLite3::Database.new("sprites.db")
DATABASE.results_as_hash = true

require_relative "database_setup.rb"
require_relative "sprite.rb"

get "/" do
  @all_sprites = Sprite.all
  erb :draw
end

get "/save" do
  Sprite.new(params).insert
  @all_sprites = Sprite.all
  erb :draw
end

get "/load/:id" do
  @all_sprites = Sprite.all
  Sprite.find(params[:id].to_i).to_hash.to_json
end

get "/admin" do
  binding.pry
  @all_sprites = Sprite.all
  erb :draw
end

