class MusicImporter
  attr_accessor :path, :files
  def initialize(path)
    @path = path
  end

  # def files
  #   @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  # end

  def files
    files = []
    Dir.new(self.path).each do |file|
      files << file if file.length > 4
    end
    files
    end
  end
  
  def import
    # files.each do {|file| Song.create_from_filename(file)}
  
  end
end