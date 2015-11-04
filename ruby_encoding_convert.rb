uuml_utf8 = "\xC3\xAD" # caracter í

puts  uuml_utf8
puts  uuml_utf8.encoding
puts  uuml_utf8.bytes
puts '---------------------'
uuml_latin1 = uuml_utf8.encode("ISO-8859-1")
puts uuml_latin1.encoding
puts uuml_latin1.bytes
puts uuml_latin1

File.open('saved_file.html', 'wb')do |f| 
  f << uuml_utf8
  f << "<br>" 
  f << uuml_latin1
end