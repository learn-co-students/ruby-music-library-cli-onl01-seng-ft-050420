require "pry"

class Song

    @@all = []

    attr_accessor :name, :artist, :genre

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if genre != nil
            self.genre = genre
        end 
        if artist != nil
            self.artist = artist
        end 

        
    end 

    def self.all
        @@all
    end 

    def self.destroy_all
        @@all.clear
    end 

    def save
        @@all << self
    end 

    def self.create(new_song)
        song = self.new(new_song)
        song.save
        return song 
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end 

    def self.find_by_name(name)
        @@all.detect do |song|
            song.name == name  
        end 
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end 

    def self.new_from_filename(filename)
        artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
        genre = Genre.find_or_create_by_name(filename.split(" - ")[2].split(".")[0])
        song = self.new(filename.split(" - ")[1],artist,genre)
    end 

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
      end
    

end