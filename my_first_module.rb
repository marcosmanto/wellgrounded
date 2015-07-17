module MyFirstModule
	def say_hello
		puts "Hello"
	end
end

class	ModuleTester
	include MyFirstModule # mix-in
end
