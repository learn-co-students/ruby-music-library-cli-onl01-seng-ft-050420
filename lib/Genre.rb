class Genre
    attr_accessor :name
    attr_reader :artists
    extend Concerns::Findable
    @@all = []
    
    def initialize(name)
    @name = name
    @songs = []
    
    end
    
    def save
    @@all << self
    end
    def songs
        @songs
    end
    
    def self.all
    @@all
    end
    
    def self.destroy_all
       @@all.clear 
    end
    
    def self.create(name)
     Genre.new(name).save
     @@all.find {|genre| genre.name == name}
    end

    def add_song(song)
        song.genre = self unless song.genre == self
        @songs << song unless @songs.include?(song)
      end

    def artists
    artists = @songs.collect {|song| song.artist}
    artists.uniq
    end

    end