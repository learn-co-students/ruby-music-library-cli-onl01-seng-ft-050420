

class Song 
  
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    @artist = artist
  end 
  
  def self.all 
    @@all
  end 
  
  def save 
    @@all << self
    self
  end 
  
  def self.destroy_all 
    @@all.clear
  end 
  
  def self.create
    self.new
    save
  end
  
  
  def add_song
    
    
  end
  
  def new_from_filename(file)
    
  end 
  
  def create_from_file(file)
    files.collect do |file |
      file.split(" - ")
      name = file[1]
      artist = file[0]
      genre = file[2]
      Song.new(name, artist, genre)
    end
  end 
  
  
  
  def find_by_name(song_name)
    @@all.find do |song|
      song.name == song_name
    end 
  end
  
  def find_or_create_by_name (song_name)
    
    find_by_name(song_name) || self.create
    
  end 
  
  
end