class Genre
  attr_accessor :name, :songs
  @@all = []
  def initialize(name)
    @name = name
    @@all << self
    @songs = []
    # save
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all   
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save 
    genre
  end
  
  def artists
    songs.collect {|songs| songs.artist}.uniq
  end
end