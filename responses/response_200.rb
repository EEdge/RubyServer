class Response200 < Response 

	def initialize(body, mime_type)
    @mime_type = mime_type
    @body = body
	end

	def respond

		<<-RESULT
HTTP/1.1 200 OK
Content-Type: #{@mime_type} Content-Length: #{@body.bytesize}

#{@body}
		RESULT

	end

end