class Response304 < Response

	def initialize()
		@time = Time.now
	end

	def respond
		<<-RESULT
HTTP/1.1 304 Not Modified
Content-Type: Text/HTML Date: #{@time.to_s}

		RESULT
	end

end