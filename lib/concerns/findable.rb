module Concerns::Findable
  
  def find_by_name(name)
    all.each { |item| return item if item.name == name}
    nil
  end
    
  def find_or_create_by_name(name)
    find_by_name(name) == nil ? create(name) : find_by_name(name)
  end
  
  
end