module Csv
  def array(path)
    file = File.new(path)
    document = []
    while !file.eof? 
      line = file.readline.strip.split(',')
      document << line
    end 
  return document
  end
end