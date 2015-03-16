class User < ActiveRecord::Base
  
  has_many :sprites
  
  validates :username, presence: true, uniqueness: true 
  validates :email, presence: true, uniqueness: true #has @ and . ?
  validates :password, presence: true, length: {minimum: 6}, confirmation: true
end