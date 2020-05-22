require_all 'lib'
require './lib/concerns/findable'

class Genre
  
  attr_accessor :name
  @@all = []
  extend Concerns::Findable
  
  def initialize(name)
    @name = name 
  end 
  
  def save
    @@all << self 
    self
  end 
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all
    @@all.clear 
  end 
  
  def self.create(name)
    n = new(name)
    n.save
    n
  end 
  
  def songs
    Song.all.filter { |song| song.genre == self}
  end
  
  def artists 
    songs.map { |song| song.artist }.uniq
  end
  
end