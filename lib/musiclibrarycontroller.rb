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
    
    input = gets.strip
    
    if input == 'list songs'
      self.list_songs
    elsif input == 'list artists'
      self.list_artists
    elsif input == 'list genres'
      self.list_genres
    elsif input == 'list artist'
      self.list_songs_by_artist
    elsif input == 'list genre'
      self.list_songs_by_genre
    elsif input == 'play song'
      self.play_song
    elsif input == 'exit'
    else
     gets.strip until gets.strip == 'exit'
    end
    
  end 
  
    def list_songs
      Song.all.sort {|song1, song2| song1.name <=> song2.name}.each.with_index(1) {|o, i| puts "#{i}. #{o.artist.name} - #{o.name} - #{o.genre.name}"}
    end
    
    def list_artists
      Artist.all.sort {|art1, art2| art1.name <=> art2.name}.each.with_index(1) {|o, i| puts "#{i}. #{o.name}"}
    end
    
    def list_genres
      Genre.all.sort {|gen1, gen2| gen1.name <=> gen2.name}.each.with_index(1) {|o, i| puts "#{i}. #{o.name}"}
    end
        
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip
      if artist = Artist.find_by_name(input)
        artist.songs.sort {|song1, song2| song1.name <=> song2.name}.each.with_index(1) {|o, i| 
            puts "#{i}. #{o.name} - #{o.genre.name}"}
      end
    end
    
    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip
      if genre = Genre.find_by_name(input)
        genre.songs.sort {|song1, song2| song1.name <=> song2.name}.each.with_index(1) {|o, i|
          puts "#{i}. #{o.artist.name} - #{o.name}"}
      end
    end
  
    def play_song
      puts "Which song number would you like to play?"
      input = gets.strip
      index = input.to_i - 1
      if index > 0 && index < Song.all.length 
        sorted = Song.all.sort {|song1, song2| song1.name <=> song2.name}
          puts "Playing #{sorted[index].name} by #{sorted[index].artist.name}"
      end
    end

end