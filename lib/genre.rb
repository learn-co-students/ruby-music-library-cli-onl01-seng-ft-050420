class Genre
  
  attr_accessor :name
  @@all = []
  
  def initialize(name)
    @name = name 
  end 
  
  def save
    @@all << self 
  end 
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all
    @@all.clear 
  end 
  
  def self.create(name)
    n = new(name)
    n.save
    n
  end 
  
  
  
  
  
end