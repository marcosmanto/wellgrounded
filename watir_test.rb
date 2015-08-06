require 'watir-webdriver'
b = Watir::Browser.new
b.goto 'bit.ly/watir-webdriver-demo'
b.text_field(:id => 'entry_1000000').set 'your name'
check_ruby = b.select_list(:id => 'entry_1000001').select 'Ruby'
puts 'Ruby selected' if check_ruby
b.select_list(:id => 'entry_1000001').selected? 'Ruby'
b.button(:name => 'submit').click
if b.text.include? 'Thank you x'
	puts 'Everything went well'
else
	puts 'A problem occurred'
end
