require 'pry'
class Artist 
  extend Concerns::Findable
  attr_accessor :name 
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name) 
    artist.save 
    artist
  end
  
  def self.destroy_all
    @@all.clear
  end

  def songs
    @songs
  end
  
  def add_song(song) #drake.add_song(INSTANCE OF A SONG NOT A STRING)
    if song.artist == nil
        song.artist = self
        @songs << song unless songs.include?(song)
    else
      @songs << song unless songs.include?(song)
    end
  end
  
  def genres #returns array of all Genre instances
    #songs.map {|song| song.genre}
    songs.map(&:genre).uniq
  end


end