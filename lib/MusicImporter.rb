class MusicImporter
  attr_accessor :path, :song, :artist, :genre, :musiclibrarycontroller
  def initialize(path)
    @path = path  # accepts a file path to parse MP3 files from
  end

  def files
    Dir.entries(@path).select! {|entry| entry.end_with?(".mp3")} # loads all the MP3 files in the path directory
                                                                 # normalizes the filename to just the MP3 filename with no path
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)  # imports the files into the library by invoking Song.create_from_filename
    end
  end

end
