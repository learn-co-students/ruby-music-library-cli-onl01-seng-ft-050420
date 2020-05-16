class Song 
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) unless artist == nil
    self.genre=(genre) unless genre == nil
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
    song = Song.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.find_by_name(name)
    self.all.detect{|song| song.name == name}
  end
  
  def self.find_or_create_by_name(song)
    find_by_name(song) || create(song)
  end
  
  def self.new_from_filename(file)
    song_string = file.split(" - ")[1]
    artist_string = file.split(" - ")[0]
    genre_string = file.split(" - ")[2].chomp(".mp3")
    artist = Artist.find_or_create_by_name(artist_string)
    genre = Genre.find_or_create_by_name(genre_string)
    song = Song.new(song_string, artist, genre)
    song
  end
  
  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end
  
  
end

# rspec spec/001_song_basics_spec.rb