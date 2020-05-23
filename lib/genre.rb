class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs, :artist

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    #save
  end

  def add_song(song)
    if song.genre == nil
      song.genre = self
      @songs << song unless @songs.include?(song)
    elsif song.genre == self
      @songs << song unless @songs.include?(song)
      end
    end

    def artists
      @songs.collect {|s| s.artist}.uniq
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

  end
