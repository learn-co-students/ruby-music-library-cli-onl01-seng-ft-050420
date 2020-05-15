class Genre 
  attr_accessor :name, :genre 
  attr_reader :song 
  @@all = []
  
  def initialize(name)
    @name = name
    save
  end
  
  def self.all
    @@all
  end
  
  def save
    self.class.all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  
  def songs 
    Song.all.select {|song| song.genre == self}
  end
  
  #How one class talks to another
  def artists
    songs.map {|song| song.artist}
  end
  
end