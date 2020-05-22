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
    elsif user_input == 'list artists'
      list_artists
    elsif user_input == 'list genres'
      list_genres
    elsif user_input == 'list artist'
      list_songs_by_artist
    elsif user_input == 'list genre'
      list_songs_by_genre
    elsif user_input == 'play song'
      play_song
    elsif user_input == 'exit'
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
    user_input = gets.strip
    
    if artist = Artist.find_by_name(user_input)
      artist.songs.sort_by{|song| song.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    user_input = gets.strip.downcase
    
    if genre = Genre.find_by_name(user_input)
      genre.songs.sort_by{|song| song.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    sorted_songs = Song.all.sort_by{|song| song.name}
    puts "Which song number would you like to play?"
    # list_songs
    index = gets.strip.to_i - 1
    # binding.pry
    if index.between?(0, sorted_songs.length)
      puts "Playing #{sorted_songs[index].name} by #{sorted_songs[index].artist.name}"
  
    end
  end
end