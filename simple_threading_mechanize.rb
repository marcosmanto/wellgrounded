require 'nokogiri'
require 'mechanize'
require 'certified'
BASE_WIKIPEDIA_URL = "https://en.wikipedia.org"
LIST_URL = "#{BASE_WIKIPEDIA_URL}/wiki/List_of_Nobel_laureates"

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
  agent.set_proxy 'marcos.filho:vabruiggcan2014@10.90.2.68', 8080
}

rows = []

t1 = Thread.new(a, rows) do
	search = "bo"
	a.get(LIST_URL) do |page|
		rows = page.parser.css('div.mw-content-ltr table.wikitable tr')
	end

	hrefs = rows[1..-2].map do |row|
	  row.css("td a").map{ |a| 
	    a['href'] if a['href'].match(/\/wiki\/#{search}/i)
	  }
	end.flatten.compact.uniq
	puts hrefs
end

t2 = Thread.new(a, rows) do
	search = "and"
	a.get(LIST_URL) do |page|
		rows = page.parser.css('div.mw-content-ltr table.wikitable tr')
	end

	hrefs = rows[1..-2].map do |row|
	  row.css("td a").map{ |a| 
	    a['href'] if a['href'].match(/\/wiki\/#{search}/i)
	  }
	end.flatten.compact.uniq
	puts hrefs
end

1.upto(1000000) {|n| print n,","}
# puts t1.value.inspect
# puts t2.value.inspect



# page = Nokogiri::HTML(open(LIST_URL, proxy: true))
# rows = page.css('div.mw-content-ltr table.wikitable tr')

# require 'thread'
# @music = Mutex.new
# @violin = ConditionVariable.new
# @bow = ConditionVariable.new
# @violins_free = 2
# @bows_free = 1
# @runs = 0
# @played_by = Hash.new(0)
# def musician(n)
# 3.times do
# sleep rand
# @music.synchronize do
# @violin.wait(@music) while @violins_free == 0
# @violins_free -= 1
# puts "#{n} has a violin"
# puts "violins #@violins_free, bows #@bows_free"
# @bow.wait(@music) while @bows_free == 0
# @bows_free -= 1
# puts "#{n} has a bow"
# puts "violins #@violins_free, bows #@bows_free"
# end
# sleep rand
# puts "#{n}: (…playing…)"
# sleep rand
# puts "#{n}: Now I've finished."
# @played_by[n] += 1
# @runs += 1
# @music.synchronize do
# @violins_free += 1
# @violin.signal if @violins_free == 1
# @bows_free += 1
# @bow.signal if @bows_free == 1
# end
# end
# end
# threads = []
# 3.times {|i| threads << Thread.new { musician(i) } }
# threads.each {|t| t.join }
# puts "Runs: #@runs"
# puts @played_by.inspect