require 'pry'
class MusicLibraryController 
  
  attr_accessor :path 
  
  def initialize(path = "./db/mp3s")
    
    new_importer = MusicImporter.new(path)
    Song.all << new_importer.import
    
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
    respond = gets.strip
    
    call if respond != "exit"
    case respond 
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
  
  def list_songs 
    
    sorted_song =  Song.all.sort_by{|a,b| a.name <=> b.name}
    sorted_song.each_with_index do |song, index|
      puts  "#{index + 1}. #{song.artist.name}"
    end 
  end 
  
  
  def list_artists
    sorted_song =  Song.all.sort{|a,b| a.name <=> b.name}
    sorted_song.each_with_index do |song, index|
      puts puts "#{index + 1}. #{artist.name}"
    end
  end 
  
  def list_genres
    sorted_song =  Song.all.sort{|a,b| a.name <=> b.name}
    sorted_song.each_with_index do |song, index|
      puts "#{index + 1}. #{genre.name}"
    end
    
  end 
  
  
  def list_songs_by_artist
    
    puts "Please enter the name of an artist:"
    input = gets.chomp
    
    if artist = Artist.find_by_name(input)
      sorted_songs = artist.songs.sort_by {|song| song.name}
      sorted_songs.each.with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end 
    
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    
    if genre = Genre.find_by_name(input)
      sorted_songs = genre.songs.sort {|a, b| a.name <=> b.name}
      sorted_songs.each.with_index {|song,index|  puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
 
  end 
    
  
  
  def play_song
    
    sorted_songs = Song.all.sort {|a,b| a.name <=> b.name}
    puts "Which song number would you like to play?"
    
    
    input = gets.strip.to_i 
    if (1..Song.all.length).include?(input)
      song = sorted_songs[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
    
  end 
  
  
  
  
   
  
end