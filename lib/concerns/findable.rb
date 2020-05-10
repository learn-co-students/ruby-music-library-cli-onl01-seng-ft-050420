module Concerns::Findable

  def find_by_name(name)
    self.all.detect { |el| el.name == name }
  end 

  def find_or_create_by_name(name)
    el = self.find_by_name(name)
    el == nil ? self.create(name) : el 
  end

  def sort_by_name
    self.all.sort_by {|el| el.name}
  end

end 
