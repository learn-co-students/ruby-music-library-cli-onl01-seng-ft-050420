class Song 
  attr_accessor :name 
  
  @@all = []
  
  def initialize(name)
    @name = name
    save
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
    def save
    self.class.all << self
  end
  
  def create(name)
    @name = name
    save
    name
  end
  
end