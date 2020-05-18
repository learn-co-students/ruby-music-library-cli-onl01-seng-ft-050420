class Song 
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil 
    self.genre = genre if genre != nil
  end
  
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self 
    end
  end
  
  def self.find_by_name(name) #string
    @@all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name) #string
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create(name)
    end  
  end
  
  def self.new_from_filename(file)
    genre = Genre.find_or_create_by_name(file.split(" - ")[2].gsub(".mp3", ""))
    artist = Artist.find_or_create_by_name(file.split(" - ")[0])
    name = file.split(" - ")[1]
    self.new(name, artist, genre)
  end
  
  def self.create_from_filename(file)
    new_song = self.new_from_filename(file)
    new_song.save
    new_song
  end
  
end