class Genre 
  extend Concerns::Findable
  attr_accessor :name, :songs 
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
    save
  end 
  
  def artists 
    self.songs.collect {|song| song.artist}.uniq
  end 
  
  def songs 
    Song.all.select {|song| song.genre == self}.uniq
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