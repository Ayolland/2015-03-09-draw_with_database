get "/" do
  @all_sprites = Sprite.all
  erb :draw
end

get "/save" do
  Sprite.new(params).save
  {yup: "SPRITE SAVED"}.to_json
end

get "/load/:id" do
  Sprite.find(params[:id].to_i).to_hash.to_json
end

get "/delete/:id" do
  Sprite.find(params[:id]).delete
end

get "/admin" do
  @all_sprites = Sprite.all
  erb :admin
end

