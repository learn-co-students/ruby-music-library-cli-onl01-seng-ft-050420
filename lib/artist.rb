require_all 'lib'
require './lib/concerns/findable'
require 'pry'

class Artist
  
  attr_accessor :name 
  @@all = []
  extend Concerns::Findable
  
  def initialize(name)
    @name = name
    @songs = []
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
    @songs
  end
  
  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if !@songs.include?(song)
  end
  
  def genres 
    songs.map { |song| song.genre }.uniq
  end
  
end