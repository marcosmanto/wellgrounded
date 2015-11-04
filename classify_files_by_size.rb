require 'set'

#### SET VERSION ####
files = Set.new(Dir["*"]) # current directory
hash = files.classify do |f|
	if File.size(f) <= 10_000 				# até 10.000 bytes ou 10 KB
		:small
	elsif File.size(f) <= 10_000_000 	# acima de 10 KB até 10 MB
		:medium
	else 															# acima de 10 MB
		:large
	end
end
_big_files = hash[:large] # big_files is a Set

#### HASH WITH FILENAMES AND SIZES ####
# files =  Dir["C:/Users/marcos.filho/Desktop/wellgrounded/*"].map do |file|
# 	[File.basename(file), File.size(file)]
# end.sort_by{|x| x[1]}.reverse.to_h
# p files

#### HASH VERSION ####
files = Hash.new{|h, key| h[key] = [] } # cap. 8.2.2 'The Ruby Way'

Dir["C:/Users/marcos.filho/Desktop/wellgrounded/*"].each do |file|
	if File.size(file) <= 10_000
		files[:small] << File.basename(file)
	elsif File.size(file) <= 10_000_000
		files[:medium] << File.basename(file)
	else
		files[:large] << File.basename(file)
	end
end

p files
		



