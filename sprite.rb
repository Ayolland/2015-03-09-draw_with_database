class Sprite
  
  attr_accessor :pixel_array, :id, :name
  
  def initialize(options)
    @id = options["id"] || options[:id]
    @name = options["name"] || options[:name]
    @pixel_matrix = []
    16.times do |y|
      @pixel_matrix[y] = []
      16.times do |x|
        key_str = "x" + x.to_s + "y" + y.to_s
        @pixel_matrix[y][x] = options[key_str] || options[key_str.to_sym]
      end
    end
  end
  
  def self.find(id)
    sql_str = "SELECT * FROM sprites WHERE id = #{id}"
    Sprite.new(DATABASE.execute(sql_str)[0])
  end
  
  def self.all
    sql_str = "SELECT * FROM sprites"
    results = DATABASE.execute(sql_str)
    results.map { |hash| Sprite.new(hash) }
  end
  
  def insert
    if @id == nil
      key_str, val_str = splitter
      sql_str = "INSERT INTO sprites (#{key_str}) VALUES (#{val_str})"
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
      DATABASE.execute(sql_str)
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
        hash[symb] = @pixel_matrix[x][y]
      end
    end
    hash
  end
  
  def splitter
    key_arr, val_arr = [],[]
    h = self.to_hash
    h.delete(:id)
    h.each do |k,v|
      key_arr << k
      if v.length > 1 && v.to_i == 0
        val_arr << "'" + v + "'"
      else
        val_arr << v
      end
    end
    key_str = key_arr.join(", ")
    val_str = val_arr.join(", ")
    return key_str, val_str
  end
  
end