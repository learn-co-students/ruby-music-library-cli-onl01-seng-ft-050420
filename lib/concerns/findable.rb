module Concerns
  module Findable

      def find_by_name(name)
          self.all.detect{|a| a.name == name}
      end

      def find_or_create_by_name(name)
        if self.find_by_name(name) != nil
           self.find_by_name(name)
        else
          song = self.create(name)
          song
        end
      end
    end 
end
