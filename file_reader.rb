class File
	def to_s
		string = ""

		self.each do |line| 
			string += line
		end
		string
	end
end