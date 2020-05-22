require 'pry'
class Song 
  extend Concerns::Findable
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
  
  def self.create(name, artist= nil, genre = nil)
    self.new(name, artist, genre)
  end 
  
  def artist=(artist)
   
    if artist.class == Artist  
      @artist = artist 
    elsif Artist.find_or_create_by_name(artist)
      @artist = Artist.find_by_name(artist)
    else 
      @artist = Artist.new(artist)
    end 
    #binding.pry
    
  end 
  
  def genre=(genre)
    if genre.class == Genre 
      @genre = genre 
    elsif Genre.find_or_create_by_name(genre)
      @genre = Genre.find_by_name(genre)
    else 
      @genre = Genre.new(genre)
    end 
  end 
  
  def self.new_from_filename(files)
    info = files.split(" - ")
    name = info[1]
    artist = info[0]
    genre = info[2].chomp(".mp3")
    Song.create(name, artist, genre)
  end 
  
  def self.create_from_filename(file)
    self.new_from_filename(file)
  end 
end 