

class Response404 < Response

	def initialize(client, request)
    @body = File.new('./public_html/404.html').to_s
		status = 404

		logger = Logger.new(client)
		logger.write(request, status, 0)
	end

	def respond
    <<-RESULT
HTTP/1.1 404 Not Found
Content-Type: Text/HTML Content-Length: #{@body.size}

#{@body}
    RESULT
	end

end