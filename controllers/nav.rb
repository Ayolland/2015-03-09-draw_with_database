get "/" do
  @all_sprites = Sprite.all
  erb :draw
end

get "/view_sprite/:sprite_id" do
  @all_sprites = Sprite.all
  @viewing = Sprite.find(params[:sprite_id])
  redirect "/" if ! @viewing
  @viewing.user.username ||= "Anonymous"
  erb :draw
end

get "/pry" do #REMOVE THIS LATER
  @all_sprites = Sprite.all
  binding.pry
  erb :draw
end

get "/login" do
  erb :login
end

get "/new_user" do
  erb :new_user
end

get "/logout" do
  session.clear
  redirect "/"
end

post "/authenticate" do
  binding.pry
  user = User.find_by email: params[:email]
  if user && BCrypt::Password.new(user.password) == params[:password]
    session[:username] = user.username
    session[:user_id] = user.id
    redirect "/"
  else
    @display_msg = "Email / Password did not match."
    erb :login
  end
end

post "/create_user" do
  @user = User.new(params)
  if @user.valid?
    password_digest = BCrypt::Password.create(params[:password])
    @user.password , @user.password_confirmation = password_digest, password_digest
    @user.save
    binding.pry
    redirect "/login"
  else
    erb :new_user
  end
end