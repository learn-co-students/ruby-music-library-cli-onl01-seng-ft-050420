require 'pry'
class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.find_by_name(input)
    @@all.find {|s| s.name == input}
  end

  def self.find_or_create_by_name(input)
    found = self.find_by_name(input)
      found ? found : self.create(input)
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
    @@all << self.new(name)
    @@all[-1]
  end

    def genre=(genre)
      @genre = genre
      genre.add_song(self)
    end

    def artist=(artist)
       @artist = artist
      artist.add_song(self)
    end
    def self.new_from_filename(filename)
      artist, song, genre = filename.gsub(".mp3", "").split(" - ")
      artist_instance = Artist.find_or_create_by_name(artist)
      genre_instance = Genre.find_or_create_by_name(genre)
      new_song = self.new(song, artist_instance, genre_instance)
  end
  def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
    @@all
  end

end

































  # def self.new_from_filename(filename)
  #   artist, song, genre = filename.gsub(".mp3", "").split(" - ")
  #   new_song = self.new(song)
  #   new_song.artist = artist
  #   new_song.genre = genre
  #
  # end



# new_song.artist= new_artist
# new_song.genre= new_genre
# binding.pry

#new_song = self.find_or_create_by_name(song)
# new_song.artist= artist
# new_song.genre= genre
# @artist = result[0]
# @song = result[1]
# @genre = result[2]

#self.find_or_create_by_name(result[0], result[1],result[2].gsub(".mp3", ""))


#   parts = filename.split(" - ")
#   artist_name = parts[0]
#   song_name = parts[1].gsub(".mp3", "")
#
#   song = self.new
#   song.name = song_name
#   song.artist_name = artist_name
#   song
