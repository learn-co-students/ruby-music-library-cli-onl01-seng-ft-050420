require 'pry'

class MusicLibraryController
  attr_accessor :path

  def initialize(path='./db/mp3s') # initialize accepts one argument, the path to the MP3 files to be imported
                                   # initialize the 'path' argument defaults to './db/mp3s'
    @path = path                   # initialize creates a new MusicImporter object, passing in
                                   # the 'path' value
    MusicImporter.new(path).import # initialize creates a new MusicImporter object, passing in the 'path' value
                                   # initialize invokes the #import method on the created MusicImporter object
  end

  def call
     input = gets.strip

     if input != exit  #call loops and asks for user input until they type in exit

     puts "Welcome to your music library!"  #call welcomes the user
     puts "To list all of your songs, enter 'list songs'."  #call asks the user for input
     puts "To list all of the artists in your library, enter 'list artists'."
     puts "To list all of the genres in your library, enter 'list genres'."
     puts "To list all of the songs by a particular artist, enter 'list artist'."
     puts "To list all of the songs of a particular genre, enter 'list genre'."
     puts "To play a song, enter 'play song'."
     puts "To quit, type 'exit'."
     puts "What would you like to do?"

     case input
     when "list songs"  # 'list songs' triggers #list_songs
           list_songs
         when "list artists"  # 'list artists' triggers #list_artists
           list_artists
         when "list genres"  # 'list genres' triggers #list_genres
           list_genres
         when "list artist"  # 'list artist' triggers #list_songs_by_artist
           list_songs_by_artist
         when "list genre"  # 'list genre' triggers #list_songs_by_genre
           list_songs_by_genre
         when "play song"  # 'play song' triggers #play_song
           play_song
         end
     end
   end

  def list_songs   #list_songs prints all songs in the music library in a numbered list (alphabetized by song name)
    Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|  #list_songs is not hard-coded
      puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists  #list_artists prints all artists in the music library in a numbered list (alphabetized by artist name)
    Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |a, i|  #list_artists is not hard-coded
      puts "#{i+1}. #{a.name}"
    end
  end

  def list_genres   #list_genres prints all genres in the music library in a numbered list (alphabetized by genre name)
    Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |g, i|   #list_genres is not hard-coded
      puts "#{i+1}. #{g.name}"
    end
  end

  def list_songs_by_artist  #list_songs_by_artist prompts the user to enter an artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)  #list_songs_by_artist accepts user input
      artist.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        puts "#{i+1}. #{s.name} - #{s.genre.name}"  #list_songs_by_artist prints all songs by a particular artist in a
      end                                               # numbered list (alphabetized by song name)
    end  #list_songs_by_artist does nothing if no matching artist is found
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"  #list_songs_by_genre prompts the user to enter a genre
    input = gets.strip

    if genre = Genre.find_by_name(input)  #list_songs_by_genre accepts user input
      genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        puts "#{i+1}. #{s.artist.name} - #{s.name}"  #list_songs_by_genre prints all songs by a particular genre
                                                        # in a numbered list (alphabetized by song name)
      end
    end  #list_songs_by_genre does nothing if no matching genre is found
  end

  def play_song
    puts "Which song number would you like to play?"  #play_song prompts the user to choose a song from the
                                                          # alphabetized list output by #list_songs
    input = gets.strip.to_i  #play_song accepts user input
    if input > 0 && input <= Song.all.length   #play_song checks that the user entered a
                                                        # number between 1 and the total number
                                                        # of songs in the library
      array = Song.all.sort{|a, b| a.name <=> b.name}
      song = array[input-1]
      puts "Playing #{song.name} by #{song.artist.name}"  #play_song upon receiving valid input 'plays' the
                                                              # matching song from the alphabetized list output
                                                              #by #list_songs
    end
  end

end
