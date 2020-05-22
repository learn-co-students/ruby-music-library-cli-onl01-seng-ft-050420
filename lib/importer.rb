#require 'nokogiri'
require 'open-uri'

class MusicImporter 
  attr_accessor :path
  
  def initialize(path)
    @path = path 
  end 
  
  def files 
    @files = Dir.entries(path).delete_if {|file| !file.include?("mp3")}  
  end 
  
  def import 
    files.each do |file|
      song = Song.new(name,genre,artist)
      info = file.split(" - ")
      name = info[0]
      artist = info[1]
      genre = info[2].chomp(".mp3")
    end 
  end 
end 