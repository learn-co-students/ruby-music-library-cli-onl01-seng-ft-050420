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
     Song.create_from_filename(file)
    end 
  end 
end 