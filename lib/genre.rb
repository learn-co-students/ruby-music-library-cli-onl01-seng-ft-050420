class Genre
    extend Concerns::Findable
    attr_accessor :name, :song
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
          new_genre = Genre.new(name)
        #   new_genre.save
          new_genre
      end

      def songs
        Song.all.select{|songs|songs.genre == self}
      end 

      def artists
        songs.collect{|song| song.artist}.uniq
     end
     
end  