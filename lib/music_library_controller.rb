require 'pry'
class MusicLibraryController
     attr_accessor :path, :musicimporter, :artist, :song, :genre
    def initialize(path='./db/mp3s')
      new_object=MusicImporter.new(path)
      new_object.import
    end
     
    def call
      input = ""
      while input != "exit"
      puts "Welcome to your music library!"
      puts "What would you like to do?"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      input = gets.strip
       if input == 'list songs'
        list_songs
      elsif input == 'list artists' 
        list_artists
      elsif input ==  'list genres'
        list_genres
      elsif input ==  'list artist'
        list_songs_by_artist
      elsif input == 'list genre'
        list_songs_by_genre
      elsif input == 'play song' 
        play_song
      end
    
     end
    end

    def list_songs
      list = Song.all.sort_by{|song| song.name}
      list.each_with_index do |song, index|
       puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"    
      end
    end

    def list_artists
        list = Artist.all.sort_by{|artist| artist.name}
        list.each_with_index do |artist, index|
            puts "#{index+1}. #{artist.name}"    
           end
    end

    def list_genres
        list=Genre.all.sort_by{|genre| genre.name}
        list.each_with_index do |genre, index|
            puts "#{index+=1}. #{genre.name}"    
           end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input= gets.chomp
        list_of_artist= []
        Artist.all.detect do |artist|
          if artist.name == input
            list_of_artist = artist.songs.sort_by{|song| song.name}
            list_of_artist.each_with_index do |song, index|
              puts "#{index+=1}. #{song.name} - #{song.genre.name}"
            end
          end
        end
      end
     
      def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input= gets.chomp 
        list_of_genre= []
        Genre.all.detect do |genre|
           if genre.name == input
            list_of_genre = genre.songs.sort_by{|song| song.name}
            list_of_genre.each_with_index do |song, index|
              puts "#{index+=1}. #{song.artist.name} - #{song.name}"
            end
          end
        end
      end
     
      def play_song

        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
       
          if input.between?(1, Song.all.length)
             list = Song.all.sort_by{|song| song.name}
             chosen_song =list[input-1]
            puts "Playing #{chosen_song.name} by #{chosen_song.artist.name}"
          end
       
        
      
      end
end