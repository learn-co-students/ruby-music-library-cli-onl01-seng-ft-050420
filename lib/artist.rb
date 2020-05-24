class Artist
  attr_accessor :name, :song, :musiclibrarycontroller, :musicimporter
  extend Concerns::Findable  # Artist extends the Concerns::Findable module
  @@all = []  # @@all is initialized as an empty array

  def initialize(name)
    @name = name  # initialize accepts a name for the new artist
    @songs = []
  end

  def self.all  # all returns the class variable @@all
    @@all
  end

  def self.destroy_all  # .destroy_all resets the @@all class variable to an empty array
    @@all.clear
  end

  def save  # save adds the Artist instance to the @@all class variable
    @@all << self
  end

  def self.create(artist)
    artist = self.new(artist)  #.create initializes
    artist.save                   # and saves the artist
    artist
  end

  def songs # Artist #songs returns the artist's 'songs' collection (artist has many songs)
    @songs
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self  #add_song assigns the current artist to the song's 'artist' property (song belongs to artist)
    else
      nil  #add_song does not assign the artist if the song already has an artist
    end
    if @songs.include?(song)
      nil  # #add_song does not add the song to the current artist's collection of songs if it already exists therein
    else
      @songs << song  # #add_song adds the song to the current artist's 'songs' collection
    end
    song
  end

  def genres
    @new_array = []  ##genres returns a collection of genres for allof the artist's songs
    @songs.each do |song|  #(artist has many genres through songs)
      if @new_array.include?(song.genre)  # genres collects genres through its songs instead
                                          # of maintaining its own @genres instance variable
                                          # (artist has many genres through songs)
        nil  # genres does not return duplicate genres if the artist has more than one song
                #of a particular genre (artist has many genres through songs)
      else
        @new_array << song.genre
      end
    end
    @new_array
  end

end
