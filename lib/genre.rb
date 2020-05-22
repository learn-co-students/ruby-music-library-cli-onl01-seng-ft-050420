class Genre 
  
  attr_accessor :name 
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @song = []
  end 
  
  def self.all 
    @@all
  end 
  
  def save 
    @@all << self
    self
  end 
  
  def self.destroy_all 
    @@all.clear
  end 
  
  def self.create
    self.new
    save
  end
  
  def artists 
  end 
  
  
end