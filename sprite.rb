class Sprite
  
  attr_accessor :pixel_array, :id
  
  def initialize(options)
    @id          = options["id"]          || options[:id]
    @pixel_array = options["pixel_array"] || options[:'pixel_array']
  end
  
  def self.find(id)
    
  end