class MusicImporter

  attr_accessor :path

  def initialize (path)
    @path = path
  end

  def files
    clean_array = Array.new
    Dir.glob("#{@path}/*.mp3").each do |file|
      clean_array << file.gsub("#{@path}/", "")
    end
    clean_array
  end

  def import
    self.files.each do |songs|
      Song.create_from_filename(songs)
    end
  end

end
