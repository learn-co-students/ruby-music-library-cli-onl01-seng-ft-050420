require 'pry'
class Artist
    attr_accessor :name
    extend Concerns::Findable
    @@all = []
    
    def initialize(name)
    @name = name
    @songs = []
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
     Artist.new(name).save
     @@all.find {|artist| artist.name == name}
    end

    def songs
        @songs
    end
    
    def add_song(song)
        song.artist = self unless song.artist == self
        @songs << song unless @songs.include?(song)
      end
    def genres
        genres = @songs.collect do |song|
          song.genre
        end
        genres.uniq
      end
   
    end