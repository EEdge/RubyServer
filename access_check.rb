class AccessCheck

	def initialize(request, path,http_configure)
		@request = request
		@path = path
		@http_configure = http_configure
		@htaccess_location = ""
	end

	def check
		if self.authorized? then
			@path
		else
			raise Exception403
		end
	end

	def authorized?
		if self.has_htaccess? then
			if @request[:headers][:Authorization] then
				self.generate_htaccess_location

				htaccess_hash = Hash.new

				htaccess = File.new(@htaccess_location).to_s
				htaccess = htaccess.split "\n" 
				htaccess.each do |key_val| 
					key_val = key_val.split " "
					htaccess_hash[key_val[0].to_sym] = key_val[1]
				end

				user_password_pair = File.new(htaccess_hash[:AuthUserFile]).to_s
				user_password_pair = user_password_pair.split(":")

				compare_string = user_password_pair[1].gsub(/{SHA}/, '')

				given_string = @request[:headers][:Authorization].split(" ")[1].chomp


				return compare_string == given_string
			
			else
				raise Exception401
			end
		else
			return true
		end
	end

	def has_htaccess?

		path = @path.split("/")
		sub_path = ""

		path.any? do |directory| 

			sub_path += directory
			sub_path += "/"

			File.exist?(sub_path + ".htaccess")

		end

	end

	def generate_htaccess_location

		path = @path.split("/")
		sub_path = ""

		path.each do |directory| 

			sub_path += directory
			sub_path += "/"

			@htaccess_location = 
				sub_path + ".htaccess" if File.exist?(sub_path + ".htaccess")

		end
	end

end