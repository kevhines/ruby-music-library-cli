module Concerns::Findable
        def find_by_name(name)
            self.all.detect do |type|
                type.name == name
            end
        end

        def find_or_create_by_name(name)
            song = self.find_by_name(name)
            song = self.create(name) unless song
            song
        end
 
end
