
configure :development do
  require "sqlite3"
  set :database, {adapter: "sqlite3", database: "sprites.db"}
end

configure :production do  
  require "pg"
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

unless ActiveRecord::Base.connection.table_exists?(:sprites)
 ActiveRecord::Base.connection.create_table :sprites do |t|
   16.times do |y|
     16.times do |x|
       t.integer "x" + x.to_s + "y" + y.to_s
     end
   end
   t.text :name
   t.integer :user_id
 end
end

unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |t|
    t.string :username
    t.string :email
    t.text :password
    t.integer :permission
  end  
end