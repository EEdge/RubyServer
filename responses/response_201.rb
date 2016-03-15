class Response201 < Response

	def initialize(client, request)
		@body = File.new('./public_html/201.html').to_s
    status = 201

    logger = Logger.new(client)
    logger.write(request, status, 0)
	end

	def respond

		<<-RESULT
HTTP/1.1 201 No Content
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
		RESULT
	end

end