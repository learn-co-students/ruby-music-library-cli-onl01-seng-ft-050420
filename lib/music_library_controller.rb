class MusicLibraryController

    def initialize(path='./db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        input  = ""
        until input == 'exit'
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
        when 'list songs'
            list_songs
        when 'list artists'
            list_artists
        when 'list genres'
            list_genres
        when 'list artist'
            list_songs_by_artist
        when 'list genre'
            list_songs_by_genre
        when 'play song'
            play_song
        end
    end

    end

    def list_songs
        sorted_songs = Song.all.sort_by{|song| song.name}
        sorted_songs.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        artist_array = Artist.all.collect{|artist| artist.name}
        artist_array.sort.each.with_index(1) do |artist, i|
            puts "#{i}. #{artist}"
        end
    end

    def list_genres
        genres_array = Genre.all.collect{|genre| genre.name}
        genres_array.sort.each.with_index(1) do |genre, i|
            puts "#{i}. #{genre}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        artist = Artist.find_by_name(input)
        if artist != nil
            song_name = artist.songs.collect{|song| "#{song.name} - #{song.genre.name}"}
            song_name.sort.each.with_index(1) do |song, i|
                puts "#{i}. #{song}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        genre = Genre.find_by_name(input)
        if genre != nil
            song_name = genre.songs.collect{|song| "#{song.name} - #{song.artist.name}"}
            song_name.sort.each.with_index(1) do |song, i|
                temp = song.split(" - ")
                puts "#{i}. #{temp[1]} - #{temp[0]}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if input.between?(1, Song.all.length)
            sorted_songs = Song.all.sort_by{|song| song.name}
            index = input - 1
            puts "Playing #{sorted_songs[index].name} by #{sorted_songs[index].artist.name}" 
        end
    end

end

