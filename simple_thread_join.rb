t = Thread.new do
	puts "Starting the thread"
	sleep 5
	puts "At the end of the thread"
end
puts "Outside the thread"
t.join