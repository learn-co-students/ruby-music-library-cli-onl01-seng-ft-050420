class Genre

  extend Concerns::Findable

  attr_accessor :name, :song

  @@all = []

  def initialize (name)
    @name = name
    @songs = []
    save
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

  def self.create(genre)
    genre = Genre.new(genre)
    genre.save
    genre
  end

  def add_song(song)
    song.genre = self unless song.genre
    unless @songs.include?(song)
      @songs << song
    end
  end

  def songs
    @songs
  end

  def artists
    all_artists = []
    @songs.collect do |song|
      all_artists << song.artist
    end
    all_artists.uniq
  end

end
