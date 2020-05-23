class Genre


    attr_accessor :name 

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

    def self.create(new_genre)
        genre = self.new(new_genre)
        genre.save
        return genre 
    end

    def songs
        @songs
    end 

    def add_song(song)
        if song.genre == nil
           song.genre = self
        end
        if @songs.include?(song)
          nil
        else
          @songs << song
        end
        song
    end

    def artists
        @songs.map {|song| song.artist}.uniq 
    end
end 