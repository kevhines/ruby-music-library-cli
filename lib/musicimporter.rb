class MusicImporter
attr_accessor :path

    def initialize(path)
        self.path = path
    end

    def files
        d = Dir.new(self.path)
        d.children
    end

    def import 
        self.files.each do |file|
            Song.create_from_filename(file)            
        end
    end


end