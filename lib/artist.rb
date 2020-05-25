require 'pry'
class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs 
     @@all = []
  
      def initialize(name)
          @name = name
          save
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
          new_artist = Artist.new(name)
          new_artist
      end

      def songs
          Song.all.select{|songs|songs.artist == self}
      end

      def add_song(song)
         if songs.include?(song)
         else 
            song.artist = self
         end     
      end

      def genres
         songs.collect{|song| song.genre}.uniq
      end
end     