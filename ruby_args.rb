if ARGV.empty?
  puts "No arguments supplied"
else
  ARGV.each_with_index do |arg, idx|
    puts "Argument #{idx} is: #{arg}"
  end
end