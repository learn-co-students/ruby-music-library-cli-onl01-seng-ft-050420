require_all 'lib'
require './lib/concerns/findable'

class Song
  
  attr_accessor :name, :artist, :genre
  @@all = []
  extend Concerns::Findable
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist
    self.genre = genre if genre
  end 
  
  def save
    @@all << self 
    self
  end 
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all
    @@all.clear 
  end 
  
  def self.create(name)
    n = Song.new(name)
    n.save
    n
  end
  
  def self.new_from_filename(filename)
    parsed = filename.split(" - ")
    artist_name = parsed[0]
    song_name = parsed[1]
    song_genre = parsed[2].chomp('.mp3')
    
    artist = Artist.find_or_create_by_name(artist_name)
    # song = Song.find_or_create_by_name(song_name)
    genre = Genre.find_or_create_by_name(song_genre)
    
    self.new(song_name, artist, genre)
    
  end
  
  def self.create_from_filename(filename)
    n = self.new_from_filename(filename)
    n.save
    n
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

end