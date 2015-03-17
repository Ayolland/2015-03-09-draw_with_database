class Sprite < ActiveRecord::Base
  
  belongs_to :user
  validates_associated :user
  
  def to_hash
    hash = {id: self.id, name: self.name}
    16.times do |y|
      16.times do |x|
        coord = ("x" + x.to_s + "y" + y.to_s)
        hash[coord.to_sym] = self.send(coord)
      end
    end
    hash
  end
  
end