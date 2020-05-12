require 'bundler'
Bundler.require

module Concerns
  module Findable
    
    def find_by_name(name)
      return all.find {|x| x.name == name}
    end
    
    def find_or_create_by_name(name)
      if find_by_name(name) == nil
        create(name)
      else
        find_by_name(name)
      end
    end
  end
end

require_all 'lib'

class Song

attr_accessor :name, :artist, :genre
@@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end
  
  def save
    @@all << self
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self if !@genre.songs.include?(self)
  end
  
  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    return song
  end
  
  def self.new_from_filename(filename)
    song = Song.find_or_create_by_name(filename.split(" - ")[1])
    artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2].gsub(".mp3",""))
    
    song.artist = artist
    song.genre = genre
    
    return song
  end
  
  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
  end
  
  extend Concerns::Findable
  
end

class Artist
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if !@songs.include?(song)
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    return artist
  end
  
  def genres
    artist_genres = []
    
    @songs.each do |x|
      artist_genres << x.genre if !artist_genres.include?(x.genre)
    end
    
    return artist_genres
  end
  
  extend Concerns::Findable
  
end

class Genre
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    return genre
  end
  
  def artists
    genre_artists = []
    
    @songs.each do |x|
      genre_artists << x.artist if !genre_artists.include?(x.artist)
    end
    
    return genre_artists
  end
  
  extend Concerns::Findable
end

class MusicImporter
  
  attr_accessor :path, :files
  
  def initialize(path)
    @path = path
    @files = Dir.children(path)
  end
  
  def import
    @files.each do |x|
    song = Song.create_from_filename(x)
    end
  end
  
end

class MusicLibraryController
  
  attr_accessor
  
  def initialize(path = "./db/mp3s")
    music_importer = MusicImporter.new(path)
    music_importer.import
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
    
    input = ""

    until input == "exit"
      input = gets
      
      case input
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
  end
  
  def list_songs
    songs = Song.all.sort_by {|x| x.name}
    
    i = 1
    
    songs.each do |x|
      puts "#{i}. #{x.artist.name} - #{x.name} - #{x.genre.name}"
      i += 1
    end
  end
  
  def list_artists
    artists = Artist.all.sort_by {|x| x.name}
    
    i = 1
    
    artists.each do |x|
      puts "#{i}. #{x.name}"
      i += 1
    end
  end
  
  def list_genres
    genres = Genre.all.sort_by {|x| x.name}
    
    i = 1
    
    genres.each do |x|
      puts "#{i}. #{x.name}"
      i += 1
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets
    artist_songs = Song.all.select {|x| x.artist.name == artist}
    artist_songs = artist_songs.sort_by {|x| x.name}
    
    i = 1
    
    artist_songs.each do |x|
      puts "#{i}. #{x.name} - #{x.genre.name}"
      i += 1
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets
    genre_songs = Song.all.select {|x| x.genre.name == genre}
    genre_songs = genre_songs.sort_by {|x| x.name}
    
    i = 1
    
    genre_songs.each do |x|
      puts "#{i}. #{x.artist.name} - #{x.name}"
      i += 1
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    num = gets.to_i - 1
    songs = Song.all.sort_by {|x| x.name}
    
    if num > 0 && num < songs.count - 1
      puts "Playing #{songs[num].name} by #{songs[num].artist.name}"
    end
  end
  
end