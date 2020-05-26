class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path =path
  end
  
  def files 
    newarray=[]
    Dir.new(@path).entries.each do |file|
       if file.include?("mp3")
         newarray << file
       end
     end
     newarray
  end
  
  def import 
   array= self.files
    array.each do |file|
      Song.create_from_filename(file)
    end
  end
  
end