

class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    
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

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def add_song(song)
        song.artist = self if song.artist == nil
        @songs << song if !@songs.include?(song)
    end

    def genres
        genres_array = []
        @songs.each do |song| 
            if !genres_array.include?(song.genre)
                genres_array << song.genre
            end
        end
        genres_array
    end


end