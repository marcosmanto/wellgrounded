require "stacklike"
class Suitcase
end
class Cargohold
	include Stacklike
	def load_and_report(obj)
		print "Loading object"
		puts obj.object_id
		add_to_stack(obj)
	end
	def unload
		take_from_stack
	end
end