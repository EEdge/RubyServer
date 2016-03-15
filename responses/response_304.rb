class Response304 < Response

	def initialize(client, request)
		@time = Time.now
		status = 304

		logger = Logger.new(client)
		logger.write(request, status, 0)
	end

	def respond
		<<-RESULT
HTTP/1.1 304 Not Modified
Content-Type: Text/HTML Date: #{@time.to_s}

		RESULT
	end

end