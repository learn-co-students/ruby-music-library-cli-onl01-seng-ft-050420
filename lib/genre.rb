class Genre 
  attr_accessor :name 
  extend Concerns::Findable
  @@all = []
  def initialize(name)
    @name = name
  end
  def self.all
    @@all
  end
  def save
    @@all << self
  end
  def self.destroy_all
    @@all = []
  end
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  def songs 
    Song.all.select{|song| song.genre == self}
  end
  def artists
    self.songs.collect{|song| song.artist}.uniq 
  end
end