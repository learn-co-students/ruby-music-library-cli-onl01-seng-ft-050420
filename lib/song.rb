class Song
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def self.all
    @@all 
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name).tap do |el|
      el.save
    end
  end

  def artist
    @artist
  end

  def genre
    @genre
  end

  def artist=(artist)
    artist.add_song(self) unless artist.songs.include?(self)
    @artist = artist
  end

  def genre=(genre)
    genre.add_song(self) unless genre.songs.include?(self)
    @genre = genre
  end

  def self.new_from_filename(filename)
    parsed_filename = filename.split(" - ")
    song = self.new(parsed_filename[1])
    artist = Artist.find_or_create_by_name(parsed_filename[0])
    genre = Genre.find_or_create_by_name(parsed_filename[2].slice(0...-4))
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    @@all << song
  end 

  # def self.sort_by_name
  #   self.all.sort_by {|el| el.name}
  # end

end