class MusicImporter
  attr_accessor :path
  @@all = []
  def initialize(path)
    @path = path 
    @@all << self
  end
  def files
    Dir.entries(path).reject{|file| file == "." || file == ".."}
  end
  def import 
    self.files.each{|filename| Song.create_from_filename(filename)} 
  end
end 