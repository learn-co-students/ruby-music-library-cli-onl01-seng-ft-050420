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

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name).tap do |el|
      el.save
    end
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