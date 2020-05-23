class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.glob("#{path}/*.mp3").map {|file| File.basename file }
   #Dir.glob("#{path}/*.mp3").map {|file| file.gsub("#{path}/", '')}
   #Dir.each_child(path).map {|file| file}
   #Dir.entries(path) - %w[. ..]
  end

def import
  files.each do |files|
    Song.create_from_filename(files)
  end
end




end
