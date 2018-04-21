def conver_csv_to_array(file)
  document = []
    while !file.eof? 
      line = file.readline.strip.split(',')
      document << line
    end 
  p document
  return document
end 

def print_names(document_name)
  file = File.open(document_name, 'r')
  document = conver_csv_to_array(file)
  puts "#{document.length} Names"
  puts "-" * 10
  document.sort.uniq[0..document.length].each do |full_name|
    puts "#{full_name[1]} #{full_name[0]}"
  end
end

print_names("names.csv")