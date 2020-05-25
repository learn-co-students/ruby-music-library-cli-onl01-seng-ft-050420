require 'pry'
class Song
  
    extend Concerns::Findable
  attr_accessor :name, :artist
   @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist)
        self.genre=(genre)
      end
    
    def genre=(genre)
        @genre=genre
    end

    def genre
        @genre
    end
    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        new_song = self.new(name)
        new_song.save
        new_song
    end
     
    def self.new_from_filename(filename)
        new_array=filename.split(" - ")
        new_genre= new_array[2].gsub(".mp3", "")
        new_song= self.new(new_array[1])
        new_song.artist = Artist.find_or_create_by_name(new_array[0])
        new_song.genre = Genre.find_or_create_by_name(new_genre)
        new_song
    end

    def self.create_from_filename(filename)
        new_song=self.new_from_filename(filename) 
        new_song.save 
    end
   
end