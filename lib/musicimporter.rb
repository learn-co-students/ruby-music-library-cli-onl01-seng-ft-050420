
require 'pry'

class MusicImporter
  
  attr_accessor :path 
  
  def initialize(path)
    @path = path
  end 
  
  def files(path)
    files = Dir.entries(path).delete_if { |s| s == " "  &&  s == "."  &&  s == ","}
  end
  
  def self.import
    files.each do |file| 
      Song.new_by_filename(file)
    end 
  end
end 