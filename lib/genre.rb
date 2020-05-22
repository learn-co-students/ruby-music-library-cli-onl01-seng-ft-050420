

class Genre
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
        genre = self.new(name)
        genre.save
        genre
    end

    def artists
        artist_array = []
        @songs.each do |song|
            if !artist_array.include?(song.artist)
                artist_array << song.artist
            end
        end
        artist_array
    end
end