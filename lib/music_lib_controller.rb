require 'pry'
class MusicLibraryController 
  attr_accessor :path
  
  def initialize(path="./db/mp3s")
    @path =path 
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
    Song.all.sort{|a,b| a.name <=> b.name}.each.with_index(1){|song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end 
  
  def list_artists
    Artist.all.sort{|a,b| a.name <=> b.name}.each.with_index(1){|artist, index| puts "#{index}. #{artist.name}"}
  end 
  
  def list_genres 
    Genre.all.sort{|a,b| a.name <=> b.name}.each.with_index(1){|genre, index| puts "#{index}. #{genre.name}"}
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    respond = gets.strip 
    artist = Artist.find_by_name(respond)
    Song.all.select {|song| song.artist == artist}.sort{|a,b| a.name <=> b.name}.each.with_index(1){|song, index| puts "#{index}. #{song.name} - #{song.genre.name}"}
  end 
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    respond = gets.strip
    genre = Genre.find_by_name(respond)
    Song.all.select {|song| song.genre == genre}.sort{|a,b| a.name <=> b.name}.each.with_index(1){|song, index| puts "#{index}. #{song.artist.name} - #{song.name}"}
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    respond = gets.strip
    index = respond.to_i - 1 
    songs = Song.all.sort{|a,b| a.name <=> b.name}
    puts "Playing #{songs[index].name} by #{songs[index].artist.name}" if index.between?(0, songs.length-1)
  end 
end 