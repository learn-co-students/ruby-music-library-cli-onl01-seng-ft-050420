class Artist 
  attr_accessor :name 
  extend Concerns::Findable
  @@all = []
  def initialize(name)
    @name = name
  end
  def self.all
    @@all
  end
  def save
    @@all << self
  end
  def self.destroy_all
    @@all = []
  end
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
  def songs 
    Song.all.select{|song| song.artist == self}
  end
  def add_song(song)
    song.artist = self
  end 
  def genres
    self.songs.collect{|song| song.genre}.uniq
  end
end