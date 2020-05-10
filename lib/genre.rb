class Genre
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