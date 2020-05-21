class Artist 
  attr_accessor :name
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
    save
  end 
  
  def add_song(song)
    song.artist = self if song.artist == nil
    self.songs << song if !self.songs.include?(song)
  end 
  
  def genres 
    self.songs.collect {|song| song.genre}.uniq
  end 
  
  def songs  
    @songs 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all = []
  end 
  
  def save 
    @@all << self
  end 
  
  def self.create(name)
    self.new(name)
  end 
end 