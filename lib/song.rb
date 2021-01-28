class Song
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :artist, :genre
    
    @@all = []


    def initialize(title, artist = nil, genre = nil)
        self.name = title
        self.artist = artist unless artist == nil
        self.genre = genre unless genre == nil
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def self.create(title)
        song = self.new(title)
        song.save
        song
    end

    def self.new_from_filename(filename)
       # binding.pry
        song = self.find_or_create_by_name(filename.split(" - ")[1])
        artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
        genre = Genre.find_or_create_by_name(filename.split(" - ")[2].split(".")[0])
        song.artist = artist
        song.genre = genre
        song
    end
    
    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

end
