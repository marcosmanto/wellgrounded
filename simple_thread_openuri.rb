require 'open_uri_redirections'
require 'certified'

t = Thread.new do
	puts "Connecting to Github..."
	github = open('http://github.com', proxy:'http://10.90.2.68:8080', allow_redirections: :safe)
	puts "Connected"
	puts github.gets
end
puts "Outside the thread\n"
t.join