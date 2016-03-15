class Response204 < Response

	def initialize(client, request)
		@body = File.new('./public_html/204.html').to_s
		status = 204

		logger = Logger.new(client)
		logger.write(request, status, 0)
	end

	def respond

		<<-RESULT
HTTP/1.1 204 Created
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body.read}
		RESULT
	end

end