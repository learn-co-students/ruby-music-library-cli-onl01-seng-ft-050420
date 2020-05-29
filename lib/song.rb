require 'pry'

class Song 
  
  extend Concerns::Findable
  
  attr_accessor :name, :artist, :genre 
   
  
  
  @@all = []
  
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
    save
  end 
  
  
  # def genre=(genre)
  #   genre.songs << self unless genre.songs.include?(self)
  #   @genre = genre
  # end 
  
  # def artist=(artist)
  #   artist.songs << self unless artist.songs.include?(self)
  #   @artist = artist
  # end 
  
  
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
  
  
  
  def self.create(name)
    song_inst = self.new(name)
    song_inst
  end
  
  
  
  
  def self.new_from_filename(file)
    data = file.split(" - ")
    song_name = data[1]
    artist_name = data[0]
    song_genre= data[2].chomp(".mp3")
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(song_genre)
    
    Song.new(song_name, artist, genre)
  end 
  
  
  
  def self.create_from_filename(file)
    new_song = self.new_from_filename(file)
    
  end 
  
 
  
  
  
  
end