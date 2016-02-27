class Configure 

	attr_reader :configure_file_string

	def initialize(string)
		@configure_file_string = string
	end

	def load
		configuration_hash = Hash.new
		@configure_file_string.split("\n").select do |line|
			line.chomp
			line[0] != "#" && !line.empty?
		end.map do |line| 
			line.split(" ")
		end.map do |line_array|
			configuration_hash[line_array.first.to_sym] = line_array.last
		end
	end

end