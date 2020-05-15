class Artist 
 attr_accessor :name, :songs 
  
  @@all = []
  
  
  def initialize(name)
    @name = name
    save
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
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
    @songs
  end 
  
  def add_song(song, artist = self)
    @songs << song if !@songs.include?(song)
    song.artist = artist if song.artist == nil 
  end

  
#  def new_song(name, genre)
#    Song.new(name, self, genre)
#  end
  
  #How one class talks to another
#  def genres
#    songs.map {|song| song.genre}
#  end 
 
#Song.all.select {|song| song.artist == self}
end