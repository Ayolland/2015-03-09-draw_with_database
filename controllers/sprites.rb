get "/save" do
  Sprite.new(params).save
  {sprite_id: Sprite.last.id}.to_json
end

get "/load/:id" do
  Sprite.find(params[:id].to_i).to_hash.to_json
end

get "/delete/:id" do
  Sprite.find(params[:id]).delete
end

