class Song 
  attr_accessor :name, :artist, :genre
  extend Concerns::Findable
  @@all = []
  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist
      self.artist = artist
    end
    if genre
      self.genre = genre
    end
  end
  def self.all
    @@all
  end
  def save
    @@all << self
    self
  end
  def self.destroy_all
    @@all = []
  end
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end
  def self.new_from_filename(filename)
    song = filename.split(" - ")
    name = song[1]
    artist = Artist.find_or_create_by_name(song[0])
    genre = Genre.find_or_create_by_name(song[2].chomp(".mp3"))
    Song.new(name, artist, genre)
  end
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end
end