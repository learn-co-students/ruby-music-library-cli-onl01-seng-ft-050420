class Song 
  attr_accessor :name
  attr_reader :artist, :genre
  @@all =[]
  def initialize(name, artist=nil, genre=nil)
    @name =name
    self.artist=(artist) if artist !=nil 
    self.genre=genre if genre!=nil
  end
  
  def save
    @@all << self 
  end
  
  def self.all 
    @@all
  end
  
  def artist=(artist)
    @artist =artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    if self.genre==nil
     @genre =genre
     self.genre.songs << self
    end
  end
  
  def self.find_by_name(name)
    self.all.find {|song| song.name==name}    
  end
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
       self.find_by_name(name)
    else
      self.create(name)
    end
  end
  
  def self.new_from_filename(filename)
    name =filename.split(" - ")[1]
    artist =filename.split(" - ")[0]
    genre =filename.split(" - ")[2].split(".")[0]
    song= Song.new(name)
    song.artist =Artist.find_or_create_by_name(artist)
    song.genre =Genre.find_or_create_by_name(genre)
    song
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
  
  def self.create(info) 
    song=Song.new(info)
    song.save
    song
  end
  
  def self.destroy_all
    @@all.clear
  end
end