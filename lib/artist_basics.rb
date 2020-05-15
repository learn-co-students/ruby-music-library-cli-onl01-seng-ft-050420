class Artist 
 attr_accessor :name 
  
  @@all = []
  
  
  def initialize(name)
    @songs = []
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
  
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
  
  def songs
    Song.all.select {|song| song.artist == self}
  end 
  
  
  
  def add_song(song, artist = self)
    @song << song
    song.artist = artist
  end
  
  def new_song(name, genre)
    Song.new(name, self, genre)
  end
  
  #How one class talks to another
  def genres
    songs.map {|song| song.genre}
  end 
 
  
end