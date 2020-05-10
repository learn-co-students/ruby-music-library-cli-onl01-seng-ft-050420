class Artist
  extend Concerns::Findable
  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods

  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all 
  end
  
  def add_song(song)
    unless song.artist == self
      @songs << song
      song.artist = self
    end 
  end 

  def songs
    @songs
  end

  def genres
    self.songs.map{ |song| song.genre }.uniq
  end 
end 