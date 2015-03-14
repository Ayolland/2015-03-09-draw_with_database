get "/" do
  binding.pry
  @all_sprites = Sprite.all
  erb :draw
end

get "/save" do
  binding.pry
  Sprite.new(params).insert
  # @all_sprites = Sprite.all
  # erb :draw
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

