require 'pry'

class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize (name, artist= nil, genre = nil)
    @name = name
    self.genre=(genre) if genre
    self.artist=(artist) if artist
  end

  def save
    unless @@all.include?(self)
    @@all << self
  end

  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(song)
    song = Song.new(song)
    song.save
    song
  end

  def self.new_from_filename(filename)
    song_array = []
      filename.split(" - ").join(", ").split(/[,.]/).collect do |song|
        song_array << song.strip
      end
    song = self.create(song_array[1])
    song.artist=(Artist.find_or_create_by_name(song_array[0]))
    song.genre=(Genre.find_or_create_by_name(song_array[2]))
    song
    end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
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
    self.all.find {|song|song.name == name}
  end

  def self.find_or_create_by_name(name)
     if self.find_by_name(name) != nil
        self.find_by_name(name)
     else
       song = self.create(name)
       song
     end
    end




end
