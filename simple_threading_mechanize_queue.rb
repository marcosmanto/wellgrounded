require 'nokogiri'
require 'mechanize'
require 'certified'
require 'benchmark'

Benchmark.bm do |x|
	x.report do
		BASE_WIKIPEDIA_URL = "https://en.wikipedia.org"
		LIST_URL = "#{BASE_WIKIPEDIA_URL}/wiki/List_of_Nobel_laureates"

		a = Mechanize.new { |agent|
		  agent.user_agent_alias = 'Mac Safari'
		  agent.set_proxy 'marcos.filho:vabruiggcan2014@10.90.2.68', 8080
		}

		search_terms = ["and","bo","jo","ma","ul","op","mi","yo"]

		# search_terms.each do |current_search|
		# 	rows = []
		# 	a.get(LIST_URL) do |page|
		# 		rows = page.parser.css('div.mw-content-ltr table.wikitable tr')
		# 	end
		# 	hrefs = rows[1..-2].map do |row|
		# 		row.css("td a").map{ |a| 
		# 		a['href'] if a['href'].match(/\/wiki\/#{current_search}/i)
		# 		}
		# 	end.flatten.compact.uniq
		# 	# puts "#########################"
		# 	# puts hrefs.inspect
		# 	# puts "#########################"
		# 	# puts
		# end

		# WITH THREADS #
		threads = []
		search_terms.size.times do |i|
			threads << Thread.new do
				current_search = search_terms[i]
				rows = []
				a.get(LIST_URL) do |page|
					rows = page.parser.css('div.mw-content-ltr table.wikitable tr')
				end
				hrefs = rows[1..-2].map do |row|
					row.css("td a").map{ |a| 
					a['href'] if a['href'].match(/\/wiki\/#{current_search}/i)
					}
				end.flatten.compact.uniq
				# puts "#########################"
				# puts hrefs.inspect
				# puts "#########################"
				# puts
			end
		end

		threads.each(&:join)
		####

	end
end

# t1 = Thread.new(a) do
# 	search = "bo"
# 	a.get(LIST_URL) do |page|
# 		rows = page.parser.css('div.mw-content-ltr table.wikitable tr')
# 	end

# 	hrefs = rows[1..-2].map do |row|
# 	  row.css("td a").map{ |a| 
# 	    a['href'] if a['href'].match(/\/wiki\/#{search}/i)
# 	  }
# 	end.flatten.compact.uniq
# end


