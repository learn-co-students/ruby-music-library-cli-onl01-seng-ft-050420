
class Song
    attr_accessor :name
    attr_reader  :artist, :genre

    @@all = []
    
    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist != nil
        self.genre = genre if genre !=nil
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
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self if !(genre.songs.include?(self))
    end

    def self.find_by_name(name)
        @@all.detect{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) == nil ? self.create(name) : self.find_by_name(name)
    end

    def self.new_from_filename(filename)
        file_array = filename.split(" - ")
        a = Artist.find_or_create_by_name(file_array[0].strip)
        genre_array = file_array[2].split(".")
        g = Genre.find_or_create_by_name(genre_array[0].strip)
        song = self.new(file_array[1].strip, a, g)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
end