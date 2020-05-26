require 'pry'

class Artist 
  
  extend Concerns::Findable
  
  attr_accessor :name 
  
  @@all = []
  
  def initialize(name)
    @name = name 
    
    save
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
  
  def self.create(artist_name)
    artist_inst = self.new(artist_name)
    artist_inst.save
    artist_inst
    
  end
  
  def add_song(song)
    if song.artist == nil
      song.artist = self
    end 
    if !self.songs.include?(song)
      @@all << song 
    end
  end

  
  def songs 
    
    
    Song.all.select{ |song| song.artist == self }.uniq
  end
  
  
  def genres 
    genre_arr = Song.all.collect { |song| song.genre }.uniq
    
  end 
  
end