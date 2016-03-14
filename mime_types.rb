class MimeTypes 
	attr_reader :mimetype_extensions, :mimetypes_file

	def initialize(string)
		@mimetypes_file = string
		@mimetype_extensions = Hash.new
	end

	def load 
		hash_from_file = Configure.new(@mimetypes_file).load

		hash_from_file.each do |mime_type, extension|
			if extension[0] then
				extension.each do |ext|
			        @mimetype_extensions[ext] = mime_type.to_s 
			    end 
			end
		end
		@mimetype_extensions
	end

end