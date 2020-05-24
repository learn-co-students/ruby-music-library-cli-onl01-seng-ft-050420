require 'pry'
class MusicLibraryController

  attr_accessor :path

  def initialize(path='./db/mp3s')
    @path = path
    MusicImporter.new(path).import
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
    user_input = gets.chomp
    gets.chomp until gets.chomp == "exit"

    if user_input == "list songs"
      list_songs
    elsif user_input == "list artists"
      list_artists
    elsif user_input == "list genres"
      list_genres
    elsif user_input == "list artist"
      list_songs_by_artist
    elsif user_input == "list genre"
      list_songs_by_genre
    elsif user_input == "play song"
      play_song
    else
    end

  end

  def list_songs
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each.with_index(1) do |song, index|
      # binding.pry
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by do |artist|
      artist.name
    end
    sorted_artists.each.with_index(1) do |artist, index|
      # binding.pry
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by do |genre|
      genre.name
    end
    sorted_genres.each.with_index(1) do |genre, index|
      # binding.pry
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_choice = gets.chomp
    sorted_artist = []
      Artist.all.each do |artist|
        if artist.name == artist_choice
            sorted_artist = artist.songs.sort_by do |song|
               song.name
             end
                sorted_artist.each.with_index(1) do |song, index|
                  puts "#{index}. #{song.name} - #{song.genre.name}"
                end
         else
           gets.chomp
         end
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      genre_choice = gets.chomp
      sorted_genre = []
        Genre.all.each do |genre|
          if genre.name == genre_choice
              sorted_genre = genre.songs.sort_by do |song|
                 song.name
               end
                  sorted_genre.each.with_index(1) do |song, index|
                    puts "#{index}. #{song.artist.name} - #{song.name}"
                  end
           else
             gets.chomp
           end
        end
      end


  def play_song
    puts "Which song number would you like to play?"
    sorted_songs = Song.all.sort_by {|song| song.name}
    number_choice = gets.chomp.to_i
    if (1..Song.all.size).include?(number_choice)
      puts "Playing #{sorted_songs[number_choice -1].name} by #{sorted_songs[number_choice -1].artist.name}"
    else
      gets.chomp
    end
  end


end
