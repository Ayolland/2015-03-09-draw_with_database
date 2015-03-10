class Sprite
  
  attr_accessor :pixel_array, :id
  
  def initialize(options)
    @id = options["id"] || options[:id]
    @name = options["name"] || options[:name]
    @pixel_matrix = []
    16.times do |y|
      @pixelmatrix[y] = []
      16.times do |x|
        key_str = "x" + x.to_s + "y" + y.to_s
        @pixelmatrix[y][x] = options[key_str] || options[key_str.to_sym]
      end
    end
  end
  
  def self.find(id)
    sql_str = "SELECT * FROM sprites WHERE id = #{id}"
    Sprite.new(DATABASE.execute(sql_str)[0])
  end
  
  def self.all
    sql_str = "SELECT * FROM products"
    results = DATABASE.execute(sql_str)
    results.map { |hash| Sprite.new(hash) }
  end
  
  def insert
    if @id == nil
      key_str, sql_str = splitter
      sql_str = "INSERT INTO sprites (#{key_str)}) VALUES (#{val_str})"
      DATABASE.execute(sql_str)
    end
  end
  
  def save
    if DATABASE.execute("SELECT name FROM sprites WHERE id = #{@id}")[0]
      h = self.to_hash.delete(:id)
      h.delete(:name)
      update_arr = h.each_with_object([]) do |(k,v),a|
        a << k.to_s + "=" + v.to_s
      end
      update_arr << "name='#{@name}'"
      update_str = update_arr.join(", ")
      sql_str = "UPDATE sprites SET #{update_str} WHERE id=#{@id}"
    end
  end
  
  def delete
    DATABASE.execute("DELETE FROM sprites WHERE id = #{@id}")
  end
  
  def to_hash
    hash = {id: @id, name: @name}
    16.times do |y|
      16.times do |x|
        symb = ("x" + x.to_s + "y" + y.to_s).to_sym
        hash[symb] = @pixelmatrix[x][y]
      end
    end
    hash
  end
  
  def splitter
    key_arr, val_arr = [],[]
    self.to_hash.each do |k,v|
      kay_arr << k
      val_arr << v
    end
    key_str = key_arr.join(", ")
    val_str = val_arr.join(", ")
    key_str, sql_str
  end