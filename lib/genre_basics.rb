class Genre 
  attr_accessor :name, :genre 
  attr_reader :song 
  @@all = []
  
  def initialize(name)
    @name = name
    save
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def save
    self.class.all << self
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  
  def songs
    @songs
  end
  
  def add_song(song, genre = self)
    @songs << song if !@songs.include?(song)
  end
  
  #How one class talks to another
  def artists
    uniq_artists = songs.map {|song| song.artist}
    uniq_artists.uniq
  end
  
#  def songs 
#    Song.all.select {|song| song.genre == self}
#  end
  
end