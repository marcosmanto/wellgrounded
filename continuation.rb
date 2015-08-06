require "continuation"
arr = [ "Freddie", "Herbie", "Ron", "Max", "Ringo" ]
cont = callcc {|cc| cc}
puts(message = arr.shift)
cont.call(cont) unless message =~ /Max/

## same result as:
# arr.each do |e| 
# 	puts e
# 	break if e =~ /Max/
# end