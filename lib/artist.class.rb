require 'pry'
class Artist 
  extend Concerns::Findable
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name 
    
    save
  end 
  
  def add_song(song)
    song.artist = self if song.artist == nil
    #binding.pry
    self.songs << song if !self.songs.include?(song)
    
  end 
  
  def genres 
    self.songs.collect {|song| song.genre}.uniq
  end 
  
  def songs  
    Song.all.select {|song| song.artist == self}.uniq 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all = []
  end 
  
  def save 
    @@all << self
  end 
  
  def self.create(name)
    self.new(name)
  end 
end 