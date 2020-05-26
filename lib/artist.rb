class Artist 
  attr_accessor :name,:songs
  @@all =[]
  extend Concerns::Findable
  def initialize(name)
    @name =name
    @songs=[]
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
  
 
  def add_song(song)
    # if song.artist == nil
    #   song.artist = self
    #   @songs << song
    # end
  
    
    if song.artist == nil
      song.artist = self
    end
    if !(@songs.include?(song))
      @songs << song
    end
  end
  
  # def genres 
  #   @genres=[]
  #   collection =Song.all.select {|song| song.artist==self}
  #   collection.each do |song|
  #   @genres << song.genre
  #   end
  #   @genres
  # end
  
  def genres
    @genres = []
    @songs.each do |song|
        @genres << song.genre unless @genres.include?(song.genre)
    end
    @genres
  end
  
  def self.create(info) 
    artist=Artist.new(info)
    artist.save
    artist
  end
  
  def self.destroy_all
    @@all.clear
  end
end
