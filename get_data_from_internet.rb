require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'sqlite3'

START_DATE=['12','01','2014']
END_DATE=['01','01','2015']

YURL="http://ichart.finance.yahoo.com/table.csv?a=#{START_DATE[0].to_i - 1}&b=#{START_DATE[1]}&c=#{START_DATE[2]}&d=#{END_DATE[0].to_i - 1}&e=#{END_DATE[1]}&f=#{END_DATE[2]}&g=d&ignore=.csv&s="
DBNAME = "data-hold/sp500-data.sqlite"
DB = SQLite3::Database.new( DBNAME )


SUBDIR = 'data-hold/yahoo-data'
Dir.mkdir(SUBDIR) unless File.exists?SUBDIR

DB.execute("SELECT DISTINCT ticker_symbol from companies").each do |sym|
	sym = sym.pop
	fname = "#{SUBDIR}/#{sym}.csv"
	unless File.exists?fname
		begin
			options = { proxy: 'http://10.90.2.68:8080',
									ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }
			d = open("#{YURL}#{sym}", options)
		rescue OpenURI::HTTPError => ex
			# binding.pry
			puts ex.message << ". No data for #{sym}"
			next
		end

		print "Writing file: #{fname}".ljust(50)
		File.open(fname, 'w') do |ofile|
			ofile.write(d.read)
			sleep(1.5 + rand)
		end
		puts " Done!"
	end  
end