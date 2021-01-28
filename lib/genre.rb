class Genre
    extend Concerns::Findable
    attr_accessor :name
    @@all = []


    def initialize(title)
        self.name = title
        @songs = []
    end

    def save
        @@all << self
    end

    def songs
        @songs
    end

    def add_song(song)
        song.genre = self if song.genre == nil
        @songs << song unless @songs.include?(song)
 
     end

     def artists
        songs.map do |song|
            song.artist
        end.uniq
    end

    def self.create(name)
        genre = self.new(name)
        genre.save
        genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

end