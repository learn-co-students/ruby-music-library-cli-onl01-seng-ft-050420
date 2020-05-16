class MusicLibraryController
  extend Concerns::Findable

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end 
  
  def call
    
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
      
      case input
      when "list_songs"
        list_songs
      when "list_artists"
        list_artists
      when "list_genres"
        list_genres
      when "list_artists"
        list_songs_by_artist
      when "list_genre"
        list_songs_by_genre      
      when "play_song"
        play_song
      end
    end
    
  end
  
  def list_songs
   sorted_songs = Song.all.sort_by {|song| song.name}
   sorted_songs.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end
  
  def list_artists
    sorted_songs = Artist.all.sort_by {|artist| artist.name}
    sorted_songs.each {|artist, index| puts "#{index + 1}. #{artist.name}"}
  end 
  
  def list_genres
    sorted_songs = Genre.all.sort_by {|genre| genre.name}
    sorted_songs.each {|genre, index| puts "#{index + 1}. #{genre.name}"}
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    
    if artist = Artist.find_by_name(input)
      songs_sorted_by_name = artist.songs.sort_by {|song| song.name}
      songs_sorted_by_name.each.with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end
  
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    input = gets.chomp
    
    if genre = Genre.find_by_name(input) #find genre that matches input
      songs_sorted_by_name = genre.songs.sort_by {|song|  song.name}
      songs_sorted_by_name.each.with_index {|song,index|  puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"

  end
  
end

# rspec spec/010_music_library_controller_spec.rb
# rspec spec/011_music_library_cli_methods_spec.rb
# rspec spec/012_music_library_cli_spec.rb
