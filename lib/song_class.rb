class Song 
  attr_accessor :name
  attr_reader :artist
  @@all = []
  
  def initialize(name, artist = nil)
    @name = name 
    @artist = artist
    save
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
  
  def artist=(artist_name)
    if Artist.all.include?(artist_name)
      artist_name.add_song(self) 
    else 
      Artist.create(artist_name).add_song(self)
    end 
  end 
end 