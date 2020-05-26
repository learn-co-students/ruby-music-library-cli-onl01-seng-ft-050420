class Genre
  attr_accessor :name, :songs
  @@all =[]
  extend Concerns::Findable
  def initialize(name)
    @name =name
    @songs =[]
  end
  
  def save
    @@all << self 
  end
  
  def self.all 
    @@all
  end
  
  def songs 
    @songs
  end
  
  # def artists
  #   @artists=[]
  #   collection =Song.all.select {|song| song.genre==self}
  #   collection.each do |song|
  #   @artists << song.artist
  #   end
  #   @artists.uniq
  # end
  
  def artists
    @artists = []
    @songs.each do |song|
      @artists << song.artist unless @artists.include?(song.artist)
    end    
    @artists
  end
  
   def self.create(info) 
    genre=Genre.new(info)
    genre.save
    genre
  end
  
  def self.destroy_all
    @@all.clear
  end
end