def palindrome? str
	binding.pry
  return true if str.length <= 1
  if str[0] == str[-1]
    palindrome? str[1..-2]
  end
end

def palindrome2?(str)
    str.length <= 1 or (str[0] == str[-1] and palindrome?(str[1..-2]))
end

def rock_judger(rocks_arr)
		binding.pry  
    if rocks_arr.length <= 2  # the base case
      a = rocks_arr[0]
      b = rocks_arr[-1]
    else
      a = rock_judger(rocks_arr.slice!(0,rocks_arr.length/2))
      b = rock_judger(rocks_arr)
    end    
    
    return a > b ? a : b
end

 
# rocks = 20.times.map{rand(200) + 1}
# puts rocks.join(', ')
# puts "Heaviest rock is: #{rock_judger(rocks)}"

class Person
	attr_reader   :name
	attr_accessor :key, :children
	def initialize(key,name)
		@key = key
		@name = name
		@children = []
	end
end

mroot = Person.new 100, "bill"
mroot.children.push Person.new(200, "janet"), 
										 Person.new(201, "john"), 
										 Person.new(202, "mary")
mroot.children[1].children.push Person.new(300, "tom"),
												Person.new(301, "fred")

def printChildren(person, level=0)
	puts " ".*(level) << person.name
	person.children.each do |child|
		printChildren child, level + 2
	end
end

# meningite ACWY reforço