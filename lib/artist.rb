class Artist
    extend Concerns::Findable
    attr_accessor :name
    @@all = []
  
    def initialize(name)
        self.name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def songs
        @songs
    end

    def add_song(song)
       song.artist = self if song.artist == nil
       @songs << song unless @songs.include?(song)

    end

    def genres
        songs.map do |song|
            song.genre
        end.uniq
    end
    
    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

end