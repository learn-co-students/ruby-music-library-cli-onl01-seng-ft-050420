class Song 
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) unless artist == nil
    self.genre=(genre) unless genre == nil
    save
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
  
  def self.create(name, artist=nil, genre=nil)
    song = Song.new(name, artist=nil, genre=nil)
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.find_by_name(song)
    self.all.detect{|a| a.name == song}
  end
  
  def self.find_or_create_by_name(song)
    find_by_name(song) || create(song)
  end
  
  def self.new_from_filename(file)
    song_inst = file.split(" - ")[1]
    artist_inst = file.split(" - ")[0]
    genre_inst = file.split(" - ")[2].chomp(".mp3")
    song = self.find_or_create_by_name(song_inst)
    song.artist = Artist.find_or_create_by_name(artist_inst)
    song.genre = Genre.find_or_create_by_name(genre_inst)
    song
  end
  
  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end
  
  
end

# rspec spec/001_song_basics_spec.rb