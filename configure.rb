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
			line.gsub! /"/, ''
			line.split(" ")
		end.each do |line_array|
			unless configuration_hash.include? line_array.first.to_sym then 
				configuration_hash[line_array.shift.to_sym] = line_array
			else 
				list_of_values = [].push(configuration_hash[line_array.first.to_sym], 
					line_array)
				configuration_hash[line_array.shift.to_sym] = list_of_values.flatten
			end
		end
		configuration_hash
	end

end
