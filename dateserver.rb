require 'socket'
server = TCPServer.new("127.0.0.1", 3939)
while (conn = server.accept)
	Thread.new(conn) do |c|
		c.print "Hi. What's your name? "
		name = c.gets.chomp
		c.puts "Hi, #{name}. Here's the date."
		c.puts `echo %DATE%`
		c.close
	end
end
