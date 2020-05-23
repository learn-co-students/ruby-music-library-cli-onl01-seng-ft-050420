require 'pry'
class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs, :genres


  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    #save
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
      @songs << song unless @songs.include?(song)
    elsif song.artist == self
      @songs << song unless @songs.include?(song)
      end
    end

    def genres
      @songs.collect {|s| s.genre }.uniq
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
