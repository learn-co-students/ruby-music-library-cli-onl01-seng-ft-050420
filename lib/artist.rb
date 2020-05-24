class Artist

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

  def self.create(artist)
    artist = Artist.new(artist)
    artist.save
    artist
  end

  def add_song(song)
    song.artist = self unless song.artist
    unless @songs.include?(song)
      @songs << song
    end
  end

  def songs
    @songs
  end

  def genres
    all_genres = []
    @songs.collect do |song|
      all_genres << song.genre
    end
    all_genres.uniq
end

end
