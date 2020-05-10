class Genre
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
    unless song.genre == self
      @songs << song
      song.genre = self
    end 
  end 

  def songs
    @songs
  end

  def artists
    self.songs.map{|song| song.artist}.uniq
  end 
end 