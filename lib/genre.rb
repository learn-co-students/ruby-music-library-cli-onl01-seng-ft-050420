require 'pry'

class Genre 
  
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
  
  def self.create(name)
    genre_inst = self.new(name)
    genre_inst.save
    genre_inst
  end
  
   
  
  def songs 
    Song.all.select{ |song| song.genre == self }.uniq
    
  end 
  
  def artists 
    
    songs.collect{ |song| song.artist}.uniq
    
  end
  
  
  
  
end