get "/save" do
  params[:name] ||= "Un-named"
  params[:id] = nil
  Sprite.new(params).save
  {sprite_id: Sprite.last.id}.to_json
end

get "/load/:id" do
  Sprite.find(params[:id].to_i).to_hash.to_json
end

get "/delete/:id" do
  Sprite.find(params[:id]).delete
end

get "/edit" do
  editing = Sprite.find(params[:id])
  editing.assign_attributes(params)
  editing.save
  {sprite_id: editing.id}.to_json
end

