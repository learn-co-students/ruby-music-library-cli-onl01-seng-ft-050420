class Artist

    attr_accessor :name, :songs 

    extend Concerns::Findable

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

    def self.create(new_artist)
        artist = self.new(new_artist)
        artist.save
        return artist 
    end 

    def add_song(song)
        if song.artist == nil
           song.artist = self
        end
        if @songs.include?(song)
          nil
        else
          @songs << song
        end
        song
    end

    def genres
        @songs.map {|song| song.genre }.uniq 
    end
    
end 