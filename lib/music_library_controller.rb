class MusicLibraryController

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    user_input = ""
    while user_input != "exit"
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
      case user_input
      when "list songs"
        self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      end
    end
  end

  def list_songs
    Song.sort_by_name.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end 

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    if ((1..Song.all.length).to_a.include?(input.to_i))
      song = Song.sort_by_name[input.to_i - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.sort_by_name
    sorted_artists.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end 

  def list_genres
    sorted_genres = Genre.sort_by_name
    sorted_genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_or_create_by_name(input)
    song_list = artist.songs.sort_by { |song| song.name }
    song_list.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_or_create_by_name(input)
    song_list = artist.songs.sort_by { |song| song.name }
    song_list.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre = Genre.find_or_create_by_name(input)
    song_list = genre.songs.sort_by { |song| song.name }
    song_list.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name}"
    end
  end

end