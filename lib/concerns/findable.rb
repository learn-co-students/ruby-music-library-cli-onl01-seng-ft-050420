module Concerns::Findable
  def find_by_name(name)  # .find_by_name is added as a class method
                            # to classes that extend the module
                            # .find_by_name isn't hard-coded

    self.all.detect {|e| e.name == name}    # find_by_name works exactly like a generic version of Song.find_by_name,
                                            # searching the extended class's @@all variable for an instance that matches
                                            # the provided name
  end

  def find_or_create_by_name(name)  # .find_or_create_by_name is added as a class method to classes that extend the module
                                    # .find_or_create_by_name works exactly like a generic version of Song.
                                    # find_or_create_by_name: finds (does not recreate) an existing
                                    # instance with the provided name if one exists in @@all
    self.find_by_name(name) || self.create(name)  #.find_or_create_by_name works exactly like a generic version of
                                                  # Song.find_or_create_by_name: invokes .find_by_name instead
                                                  # of re-coding the same functionality
                                                  # .find_or_create_by_name works exactly like a generic version of
                                                  # Song.find_or_create_by_name: invokes the extended class's .create method,
                                                  # passing in the provided name, if an existing match is not found
  end

end
