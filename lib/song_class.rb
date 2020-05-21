require 'pry'
class Song 
  attr_accessor :name, :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist
    self.genre = genre if genre
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
    self
  end 
  
  def self.create(name)
    self.new(name)
  end 
  
  def artist=(artist)
    @artist = artist
    #binding.pry
    @artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self if !@genre.songs.include?(self)
  end 
  
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end 
  
  def self.find_or_create_by_name(name)
    self.create(name) if !self.all.any? {|song| song.name == name}
  end 
end 