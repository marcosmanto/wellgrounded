record = File.open('C:\Users\marcos.filho\Desktop\record.txt', "w")
old_stdout = $stdout
$stdout = record
# $stderr = $stdout
puts "This is a record"
z = 10/0