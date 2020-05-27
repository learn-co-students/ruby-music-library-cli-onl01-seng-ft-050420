require 'pry'
class MusicLibraryController
    
attr_accessor :path
    def initialize(path='./db/mp3s')
    @path = path 
    MusicImporter.new(path).import
    end
def call
    uinp = ''
    while uinp != 'exit' 
    puts "Welcome to your music library!" 
    puts "To list all of your songs, enter 'list songs'."
    puts  "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts  "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    uinp =gets.strip
    case uinp
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    end
end
end

def list_songs
    Song.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |song, i|
        puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    
    end
end
def list_artists
    Artist.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |artist, i|
        puts "#{i}. #{artist.name}"
end
end

def list_genres
    Genre.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |genres, i|
        puts "#{i}. #{genres.name}"
end
end

def list_songs_by_artist
puts "Please enter the name of an artist:"
input = ''
input = gets

sorted_songs = Song.all.select{|songs| songs.artist.name == input}
sorted_songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |songs, i|  
    puts "#{i}. #{songs.name} - #{songs.genre.name}"
end
end
def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = ''
    input = gets
    
    sorted_songs = Song.all.select{|songs| songs.genre.name == input}
    sorted_songs.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |songs, i|  
        puts "#{i}. #{songs.artist.name} - #{songs.name}"
    end
    end
    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if input > 0 && input <= Song.all.length
          array = Song.all.sort{|a, b| a.name <=> b.name}
          song = array[input-1]
          puts "Playing #{song.name} by #{song.artist.name}"
        end
      end


end
