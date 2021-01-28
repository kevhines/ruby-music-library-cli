class MusicLibraryController

    attr_accessor :path

    def initialize(path = "./db/mp3s")
        self.path = path
        self.import
    end

    def import
        importer = MusicImporter.new(self.path)
        importer.import
    end

    def call
       input = ""
       until input == "exit" do
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.chomp
            case input
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
# binding.pry
        Song.all.sort_by { |song| song.name }.each_with_index do |song_sorted,i|
            puts "#{i+1}. #{song_sorted.artist.name} - #{song_sorted.name} - #{song_sorted.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort_by { |artist| artist.name}.each_with_index do |artist_sorted,i|
            puts "#{i+1}. #{artist_sorted.name}"
        end
    end

    def list_genres
        Genre.all.sort_by { |genre| genre.name}.each_with_index do |genre_sorted,i|
            puts "#{i+1}. #{genre_sorted.name}"
        end       
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        selected = Artist.all.detect { |artist| artist.name == input }
        if selected
            selected.songs.sort_by { |song| song.name }.each_with_index do |song, i|
                puts "#{i+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        selected = Genre.all.detect { |genre| genre.name == input }
        if selected
            selected.songs.sort_by { |song| song.name }.each_with_index do |song, i|
                puts "#{i+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        if input.between?(1,Song.all.size)
            song = Song.all.sort_by { |song| song.name }[input - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end





end