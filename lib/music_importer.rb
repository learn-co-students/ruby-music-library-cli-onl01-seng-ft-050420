require 'pry'
class MusicImporter

    def initialize(path)
        @path = path
    end 

    def path 
        @path 
    end 

    def files 
        @files = Dir.entries(path).delete_if{|i| !i.include?("mp3")}
    end 

    def import
        files.each do |filename|
          Song.create_from_filename(filename)
        end
    end

end 