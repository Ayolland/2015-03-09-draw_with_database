arr = []
16.times do |y|
  16.times do |x|
    arr << "x" + x.to_s + "y" + y.to_s + " INTEGER"
  end
end
                    
sql_str=  "CREATE TABLE IF NOT EXISTS sprites (id INTEGER PRIMARY KEY, name TEXT, #{arr.join(', ')})"

DATABASE.execute(sql_str)