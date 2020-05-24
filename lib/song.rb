class Song

  attr_accessor :name, :artist, :genre, :musicimporter, :MusicLibraryController
  extend Concerns::Findable

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name  # initialize accepts a name for the new song
                  # name= can set the name of a song
    self.artist=(artist) if artist !=nil  # create a new instance for self.artist if there is an artist to use (artist !=nil)
    self.genre=(genre) if genre != nil  # creat a new instance for self.genre if there is a genre to use (genre !=nil)
  end

  def self.all  # .all returns the class variable @@all
    @@all
  end

  def save # save adds the Song instance to the @@all class variable
    @@all << self
  end

  def self.destroy_all  # .destroy_all resets the @@all class variable to an empty array
    @@all.clear
  end

  def self.create(song)  # .create initializes, saves, and returns the song
    song = Song.new(song)
    song.save
    song
  end

  def artist # establishes method for artist variable
    @artist
  end

  def artist=(artist)
    @artist = artist  #initialize creates a 'songs' property set to an empty array (artist has many songs)

    artist.add_song(self) # Artist #songs returns the artist's 'songs' collection (artist has many songs)
  end

  def genre  #establishes method for genre variable
    @genre
  end

  def genre=(genre)
    @genre = genre  # tells genre to pass in an argument of genre wherein a new artist becomes
                          # part of genre.self
    genre.songs << self unless genre.songs.include?(self)  #unless that genre already is included
  end

  def self.find_by_name(name)
    @@all.detect do |song|  # .find_by_name finds a song instance in @@all by the name property of the song
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)  #this will go to an association
    # @@all.detect do |song|
    #   if song.name == name
    #     song                        # Song .find_or_create_by_name returns (does not recreate) an existing
                                        # song with the provided name if one exists in @@all
    #   else
    #     self.create(name)            # .find_or_create_by_name creates a song if an existing match is not found
    #   end
    # end
    self.find_by_name(name) || self.create(name)   #.find_or_create_by_name invokes .find_by_name instead of
                                                      # re-coding the same functionality
                                                   # .find_or_create_by_name invokes .create instead of re-coding
                                                      # the same functionality
  end

  def self.new_from_filename(filename)  # .new_from_filename initializes a song based on the passed-in filename
    array = filename.split(" - ") # describes what the array should look like when turned into a string

    song_name = array[1]
    artist_name = array[0]
    genre_name = array[2].split(".mp3").join

    artist = Artist.find_or_create_by_name(artist_name)  # accesses the Artist class
    genre = Genre.find_or_create_by_name(genre_name)  # accesses the genre class
    self.new(song_name, artist, genre) #creates a self.new that includes all of the song name, the artist, and the genre
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save  # .create_from_filename initializes and saves a song based on the passed-in filename
  end                                      # .create_from_filename invokes .new_from_filename instead of re-coding the same
                                              # functionality

end
