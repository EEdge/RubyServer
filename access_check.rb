class AccessCheck

	def initialize(path,http_configure)
		@path = path
		@http_configure = http_configure
	end

	def check
		if self.authorized? then
			@path
		else
			#throw error
		end
	end

	def authorized?
		if self.has_htaccess? then
			false
		else
			true
		end
	end

	def has_htaccess?
		false
	end

end