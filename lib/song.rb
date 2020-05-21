class Song
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name) == nil
      create(name)
    else
      find_by_name(name)
    end
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(filename)
    #"Thundercat - For Love I Come - dance.mp3"
    details = filename.split(" - ")
    name = details[1]
    artist = details[0]
    genre = details[2].split(".").shift
    
    song = self.new(name)
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)

    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    @@all << song
  end
end
