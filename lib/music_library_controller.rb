class MusicLibraryController
  def initialize(path="./db/mp3s")
    library = MusicImporter.new(path)
    library.import
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
    input = gets
    if input == "list songs"
      list_songs
    elsif input == "list artists"
      list_artists
    elsif input == "list genres"
      list_genres
    elsif input == "list artist"
      list_songs_by_artist
    elsif input == "list genre"
      list_songs_by_genre
    elsif input == "play song"
      play_song
    end
    until input == "exit"
      input = gets
    end
    
  end
  def list_songs
    i = 1
    songs = Song.all.sort_by{|song| song.name}
    songs.each do |song| 
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}" 
      i+=1
    end
  end
  def list_artists
    artists = Artist.all.sort_by{|artist| artist.name}
    i = 1
    artists.each do |artist|
      puts "#{i}. #{artist.name}"
      i+=1
    end
  end
  def list_genres
    genres = Genre.all.sort_by{|genre| genre.name}
    i = 1
    genres.each do |genre|
      puts "#{i}. #{genre.name}"
      i+=1
    end
  end
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    songs = Song.all.select{|song| song.artist.name == input}.sort_by{|song| song.name}
    i = 1 
    songs.each do |song|
      puts "#{i}. #{song.name} - #{song.genre.name}"
      i+=1
    end
  end
    def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    songs = Song.all.select{|song| song.genre.name == input}.sort_by{|song| song.name}
    i = 1 
    songs.each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name}"
      i+=1
    end
  end
  def play_song
    puts "Which song number would you like to play?"
    songs = Song.all.sort_by{|song| song.name}
    input = gets.strip.to_i
    index = input - 1
    
    if index >= 0 && index <= songs.length - 1
      puts "Playing #{songs[index].name} by #{songs[index].artist.name}"
    end
  end
end