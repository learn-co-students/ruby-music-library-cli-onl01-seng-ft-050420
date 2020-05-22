class Artist 
  
  attr_accessor :name 
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
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
  
  def add_song(song_instance)
    if song_instance.artist == nil
      song_instance.artist = self
    end
    
    @@song.find { |song| song_instance == song } || @@songs << song_instance
  end
  
  def songs 
    Song.all.collect { | song| song.name = self }
  end
  
  
  
  
  
  
  def genres 
    
  end 
  
  
  
   
   
    
  
  
  
  
end