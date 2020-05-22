require_all 'lib'
require 'pry'

class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(@path).import
  end
  

  
  def call
    
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    valid_choices = ['list songs', 'list artists', 'list genres', 'list artist', 'list genre', 'play song', 'exit']
    
    user_input = gets.strip.downcase
    until valid_choices.include?(user_input)
      puts "Sorry, that choice was invalid."
      user_input = gets.strip.downcase
    end
    
    if user_input == 'list songs'
      list_songs
    elsif 
      user_input == 'list artists'
      list_artists
    elsif
      user_input == 'list genres'
      list_genres
    elsif
      user_input == 'list artist'
      list_songs_by_artist
    elsif
      user_input == 'exit'
      return
    end
    
  end
  
  def list_songs 
    sorted_songs = Song.all.sort_by { |song| song.name }
    sorted_songs.each.with_index(1) { |song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end
  
  def list_artists
    sorted_artists = Artist.all.sort_by { |artist| artist.name }
    sorted_artists.each.with_index(1) { |artist, index| puts "#{index}. #{artist.name}" }
  end
  
  def list_genres 
    sorted_genres = Genre.all.sort_by { |genre| genre.name }
    sorted_genres.each.with_index(1) { |genre, index| puts "#{index}. #{genre.name}" }
  end
  
  def list_songs_by_artist 
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    # valid = Artist.all.map { |artist| artist.name}
    if Artist.find_by_name(user_input)
      songs = Artist.find_by_name(user_input).songs.sort_by { |song| song.name } 
      songs.each.with_index(1) { |song, index| "#{index}. #{song.name}"}
    else 
      list_songs_by_artist
    end

  end
  
  def list_songs_by_genre 
  end
  
  def play_song
  end
  
  
  
  
  
end