require "pry"
class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end


  def files
    Dir.new(self.path).select do |file|
      file.include?(".mp3")
    end
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end




end
