require_all 'lib'
require 'pry'

class MusicImporter
 
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    Dir.entries(@path).reject { |file| file[0] == '.' }
  end
  
  
  
end