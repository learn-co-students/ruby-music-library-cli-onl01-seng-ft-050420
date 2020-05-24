class Genre
  attr_accessor :name, :musiclibrarycontroller, :musicimporter
  extend Concerns::Findable # Genre extends the Concerns::Findable module
  @@all = []  # is initialized as an empty array

  def initialize(name)  # accepts a name for the new genre
    @name = name  #  retrieves the name of a genre
                  # can set the name of a genre
    @songs = []
  end

  def self.all  # returns the class variable @@all
    @@all
  end

  def self.destroy_all  # resets the @@all class variable to an empty array
    @@all.clear
  end

  def save # dds the Genre instance to the @@all class variable
    @@all << self
  end

  def self.create(genre) # initializes and saves the genre
    genre = self.new(genre)
    genre.save
    genre
  end

  def songs # returns the genre's 'songs' collection (genre has many songs)
    @songs
  end

  def artists
    @new_array = [] # returns a collection of artists for all of the genre's songs
    @songs.each do |song| # (genre has many artists through songs)
      if @new_array.include?(song.artist)
        nil  # does not return duplicate artists if the genre has more than one song by a
                 #particular artist (genre has many artists through songs)
      else
        @new_array << song.artist  # collects artists through its songs instead of maintaining
                                     # its own @artists instance variable (genre has many artists through songs)
      end
    end
    @new_array
  end


end
