
require 'pry'

class MusicImporter
  
  attr_accessor :path 
  
  def initialize(path)
    @path = path
  end 
  
  def files(path)
    files = Dir.entries(path).delete_if { |s| s == " " && s == "." && ","}
  end
  
  def self.import
  end 
end 