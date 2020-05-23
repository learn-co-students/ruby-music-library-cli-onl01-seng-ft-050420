require 'bundler'
Bundler.require

module Concerns
  # module Findable
  #
  #   def find_by_name(input)
  #     self.all.find {|s| s.name == input}
  #   end
  #
  #   def find_or_create_by_name(input)
  #     found = self.find_by_name(input)
  #         if found
  #           found
  #         else
  #           self.create(input)
  #       end
  #     end
  #
  # end
end

require_all 'lib'
