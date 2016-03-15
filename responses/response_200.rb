class Response200 < Response 

	def initialize(body, mime_type, client, request)
    @mime_type = mime_type
    @body = body
		@status = 200
    @client = client
    @request = request

    logger = Logger.new(@client)
    logger.write(@request, @status, @body.size)
	end

	def respond

		<<-RESULT
HTTP/1.1 200 OK
Content-Type: #{@mime_type} Content-Length: #{@body.size}

#{@body}
		RESULT

	end

end